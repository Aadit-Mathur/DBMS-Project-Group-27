"""Restore the reproducible schema and sample data into PostgreSQL.

Examples:
    python db_testing/restore_database.py --database-url "$env:DATABASE_URL"
    python db_testing/restore_database.py --database-url "postgresql://postgres:password@localhost:5432/ecommerce_local"

The target database should be empty, or contain no objects owned by this
project. The command uses psql because the sample data dump contains COPY
blocks, which are PostgreSQL client input rather than ordinary SQL.
"""
import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

from dotenv import load_dotenv


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SCHEMA = ROOT / "reconstruct_database" / "schema.sql"
DEFAULT_DATA = ROOT / "reconstruct_database" / "sample_data_fixed.sql"
RESTORE_TABLES = (
    "address",
    "category",
    "customer",
    "order_event",
    "order_fn_backup",
    "order_item",
    "orders",
    "payment",
    "product",
    "seller",
    "shipment",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--database-url",
        default=None,
        help="PostgreSQL connection URL (defaults to DATABASE_URL from .env)",
    )
    parser.add_argument(
        "--psql",
        default=os.getenv("PSQL_BIN") or shutil.which("psql"),
        help="psql executable (defaults to PSQL_BIN or psql on PATH)",
    )
    parser.add_argument("--schema", type=Path, default=DEFAULT_SCHEMA)
    parser.add_argument("--data", type=Path, default=DEFAULT_DATA)
    return parser.parse_args()


def run_psql(psql: str, url: str, sql_file: Path) -> None:
    command = [
        psql,
        "--no-psqlrc",
        "--set",
        "ON_ERROR_STOP=1",
        "--single-transaction",
        "--dbname",
        url,
        "--file",
        str(sql_file),
    ]
    print(f"Applying {sql_file} ...")
    subprocess.run(command, check=True)


def run_data_restore(psql: str, url: str, sql_file: Path) -> None:
    disable = "\n".join(
        f"ALTER TABLE public.{table} DISABLE TRIGGER USER;"
        for table in RESTORE_TABLES
    )
    enable = "\n".join(
        f"ALTER TABLE public.{table} ENABLE TRIGGER USER;"
        for table in RESTORE_TABLES
    )
    command = [
        psql,
        "--no-psqlrc",
        "--set",
        "ON_ERROR_STOP=1",
        "--single-transaction",
        "--dbname",
        url,
        "--command",
        disable,
        "--file",
        str(sql_file),
        "--command",
        enable,
    ]
    print(f"Applying {sql_file} with user triggers disabled during import ...")
    subprocess.run(command, check=True)


def main() -> int:
    load_dotenv(ROOT / ".env")
    args = parse_args()
    url = args.database_url or os.getenv("DATABASE_URL")

    if not url:
        print(
            "A database URL is required. Pass --database-url or set DATABASE_URL.",
            file=sys.stderr,
        )
        return 2
    if not args.psql:
        print(
            "psql was not found. Install PostgreSQL or pass --psql PATH.",
            file=sys.stderr,
        )
        return 2
    for sql_file in (args.schema, args.data):
        if not sql_file.is_file():
            print(f"SQL file not found: {sql_file}", file=sys.stderr)
            return 2

    try:
        run_psql(args.psql, url, args.schema)
        run_data_restore(args.psql, url, args.data)
    except subprocess.CalledProcessError as exc:
        print(f"Database restore failed with exit code {exc.returncode}.", file=sys.stderr)
        return exc.returncode or 1

    print("Database restore completed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
