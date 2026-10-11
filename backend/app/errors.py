"""Turn PostgreSQL errors into clear HTTP responses.

Business rules are enforced by the database (CHECK, UNIQUE, FK
constraints, the restock_product function). When one is broken,
PostgreSQL raises an error with a 5-character SQLSTATE code, and this
handler maps it to an HTTP status the frontend understands:

    23514 check_violation        -> 400  invalid value (e.g. a negative price)
    23502 not_null_violation     -> 400  required value missing
    22P02 / 22003 bad number     -> 400
    23505 unique_violation       -> 409  duplicate (e.g. email taken)
    23503 foreign_key_violation  -> 400  refers to a row that does not exist
                                 -> 409  row is still referenced (blocked delete)
    23001 restrict_violation     -> 409  row is still referenced (blocked delete;
                                         PostgreSQL 18+ uses this code for
                                         ON DELETE RESTRICT, older versions 23503)
    42501 insufficient_privilege -> 403  not your product (restock_product)
    anything else                -> 500
"""
import logging

import psycopg2
from fastapi import Request
from fastapi.responses import JSONResponse

log = logging.getLogger(__name__)

# Friendly messages by constraint name, for invalid or duplicate values
# and missing references. Unknown names fall back to PostgreSQL's own
# detail text, e.g. "Key (email)=(x) already exists."
FRIENDLY = {
    "chk_product_price": "Price cannot be negative.",
    "chk_product_stock": "Not enough stock: quantity in stock cannot go below 0.",
    "chk_product_reorder_level": "Reorder level cannot be negative.",
    "chk_seller_phone": "Phone must be 10 to 15 digits.",
    "chk_seller_email": "Email address is not valid.",
    "uq_product_seller_name": "You already have a product with this name.",
    "uq_seller_email": "A seller with this email already exists.",
    "seller_email_key": "A seller with this email already exists.",
    "uq_seller_phone": "A seller with this phone number already exists.",
    "seller_phone_key": "A seller with this phone number already exists.",
    "uq_category_name": "A category with this name already exists.",
    "category_category_name_key": "A category with this name already exists.",
    "fk_product_seller": "Seller not found.",
    "fk_product_category": "Category not found.",
    "product_category_id_fkey": "Category not found.",
}

STATUS = {
    "23514": 400,
    "23502": 400,
    "22P02": 400,
    "22003": 400,
    "23505": 409,
    "23001": 409,
    "42501": 403,
}


# Constraints may have other names on some databases (e.g. seller_email_key,
# product_category_id_fkey). Match on keywords in the name as a fallback.
KEYWORDS = {
    "23514": [("price", "Price cannot be negative."),
              ("stock", "Not enough stock: quantity in stock cannot go below 0."),
              ("quantity", "Quantity cannot be negative."),
              ("reorder", "Reorder level cannot be negative."),
              ("phone", "Phone must be 10 to 15 digits."),
              ("email", "Email address is not valid.")],
    "23505": [("email", "This email is already registered."),
              ("phone", "This phone number is already registered."),
              ("product_name", "You already have a product with this name."),
              ("category_name", "A category with this name already exists.")],
}


def friendly_by_keyword(code, constraint):
    name = (constraint or "").lower()
    for keyword, message in KEYWORDS.get(code, []):
        if keyword in name:
            return message
    return None


def is_blocked_delete(exc: psycopg2.Error) -> bool:
    """True when a DELETE/UPDATE was refused because other rows still refer to the row."""
    if exc.pgcode == "23001":
        return True
    primary = (exc.diag.message_primary or "").lower()
    return exc.pgcode == "23503" and "update or delete on table" in primary


def http_status_for(exc: psycopg2.Error) -> int:
    if exc.pgcode == "23503":
        return 409 if is_blocked_delete(exc) else 400
    return STATUS.get(exc.pgcode, 500)


async def postgres_error_handler(request: Request, exc: psycopg2.Error) -> JSONResponse:
    status = http_status_for(exc)
    if status == 500:
        log.exception("Unexpected database error", exc_info=exc)
        return JSONResponse(status_code=500, content={"error": "Database error", "sqlstate": exc.pgcode})

    constraint = exc.diag.constraint_name
    if is_blocked_delete(exc):
        message = "Cannot delete: other records still refer to it."
    else:
        message = (FRIENDLY.get(constraint) or friendly_by_keyword(exc.pgcode, constraint)
                   or exc.diag.message_detail or exc.diag.message_primary)
    return JSONResponse(
        status_code=status,
        content={"error": message, "detail": exc.diag.message_detail,
                 "constraint": constraint, "sqlstate": exc.pgcode},
    )
