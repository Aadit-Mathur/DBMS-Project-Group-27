"""One report for the dev AND production databases, in one file.

    python db_testing/inspect_orders.py

Reads the connection strings from .env (never printed, never written to the report):
    DATABASE_URL        the database you normally use (the orders-dev branch)
    DATABASE_URL_PROD   optional: the production branch (add this line to .env temporarily)
Writes db_testing/order_report.txt. Send ONLY that file (it holds no passwords or customer data).
The script only reads; it changes nothing.
"""
import os
import sys
from datetime import datetime
from pathlib import Path

import psycopg2
from dotenv import load_dotenv

HERE = Path(__file__).resolve().parent


def main() -> int:
    load_dotenv()
    sql = (HERE / "inspect_orders.sql").read_text(encoding="utf-8")
    targets = [("DEV (DATABASE_URL)", os.getenv("DATABASE_URL")),
               ("PRODUCTION (DATABASE_URL_PROD)", os.getenv("DATABASE_URL_PROD"))]
    if not targets[0][1]:
        print("DATABASE_URL is not set in .env")
        return 1

    out = [f"ORDERING MODULE REPORT  {datetime.now():%Y-%m-%d %H:%M}"]
    for label, url in targets:
        out.append("\n" + "#" * 70 + f"\n# {label}\n" + "#" * 70)
        if not url:
            out.append("(DATABASE_URL_PROD not set: production not included)")
            continue
        try:
            conn = psycopg2.connect(url, connect_timeout=20)
            conn.set_session(readonly=True, autocommit=True)       # cannot change anything
            with conn.cursor() as cur:
                cur.execute(sql)
                out.append(cur.fetchone()[0])
            conn.close()
        except psycopg2.Error as exc:
            out.append(f"could not read this database: {type(exc).__name__}")   # no URL, no password

    target = HERE / "order_report.txt"
    target.write_text("\n".join(out) + "\n", encoding="utf-8")
    print(f"Wrote {target}  ({target.stat().st_size // 1024} KB). Send me that one file.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
