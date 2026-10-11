"""Database access: a small connection pool and a transaction helper.

Every route does its work inside

    with db.transaction() as cur:
        cur.execute(...)

which commits when the block ends normally and rolls back if anything
raises. Database errors (CHECK, UNIQUE, FK violations) propagate to the
handler in errors.py, which turns them into HTTP responses.
"""
import os
import threading
from contextlib import contextmanager

import psycopg2
from dotenv import load_dotenv
from psycopg2.extras import RealDictCursor
from psycopg2.pool import ThreadedConnectionPool

load_dotenv()  # finds the .env file in the repository root

_pool = None
_pool_lock = threading.Lock()


def _get_pool() -> ThreadedConnectionPool:
    global _pool
    if _pool is None:
        with _pool_lock:
            if _pool is None:
                url = os.getenv("DATABASE_URL")
                if not url:
                    raise RuntimeError("DATABASE_URL is not set in .env")
                _pool = ThreadedConnectionPool(1, 10, url, connect_timeout=15)
    return _pool


def _healthy_connection():
    """Take a connection from the pool, replacing it if Neon closed it.

    Neon suspends idle databases, which silently closes pooled
    connections; a cheap SELECT 1 detects that before real work starts.
    """
    pool = _get_pool()
    for _ in range(3):
        conn = pool.getconn()
        try:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
            conn.rollback()
            return conn
        except psycopg2.OperationalError:
            pool.putconn(conn, close=True)
    raise psycopg2.OperationalError("Could not get a working database connection")


@contextmanager
def transaction():
    """Yield a dict-row cursor inside one transaction."""
    pool = _get_pool()
    conn = _healthy_connection()
    broken = False
    try:
        with conn:                                   # COMMIT on success, ROLLBACK on error
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                yield cur
    except psycopg2.OperationalError:
        broken = True
        raise
    finally:
        pool.putconn(conn, close=broken)
