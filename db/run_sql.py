"""Run a .sql file against the database in DATABASE_URL (read from .env).

    python db/run_sql.py db/seller_product_schema.sql
    python db/run_sql.py db/tests/seller_product_constraint_tests.sql

Works on Windows without psql installed. The file controls its own
transactions (BEGIN / COMMIT / ROLLBACK). NOTICE messages are printed.
"""
import os
import sys

import psycopg2
from dotenv import load_dotenv


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__)
        return 2

    load_dotenv()
    url = os.getenv("DATABASE_URL")
    if not url:
        print("DATABASE_URL is not set in .env")
        return 1

    path = sys.argv[1]
    with open(path, encoding="utf-8") as f:
        sql = f.read()

    conn = psycopg2.connect(url, connect_timeout=15)
    conn.autocommit = True          # the script's own BEGIN/COMMIT decide
    try:
        with conn.cursor() as cur:
            cur.execute(sql)
            if cur.description:     # last statement returned rows
                cols = [d[0] for d in cur.description]
                print(" | ".join(cols))
                for row in cur.fetchall():
                    print(" | ".join(str(v) for v in row))
    except psycopg2.Error as exc:
        for notice in conn.notices:
            print(notice.strip())
        print(f"\nFAILED ({exc.pgcode}): {exc.pgerror or exc}")
        return 1
    finally:
        notices = list(conn.notices)
        conn.close()

    for notice in notices:
        print(notice.strip())
    print(f"\nOK: {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
