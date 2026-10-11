"""Request bodies.

These models only check TYPES and required fields. Business rules
(price >= 0, phone format, unique names, stock >= 0) are deliberately
left to the database constraints, so there is one source of truth and
the DB rejects bad data even if a client bypasses the API.
"""
from decimal import Decimal
from typing import Optional

from pydantic import BaseModel, ConfigDict


class SellerCreate(BaseModel):
    model_config = ConfigDict(extra="forbid")

    name: str
    email: str
    phone: str


class ProductCreate(BaseModel):
    model_config = ConfigDict(extra="forbid")

    category_id: int
    product_name: str
    price: Decimal
    description: Optional[str] = None
    brand: Optional[str] = None
    quantity_in_stock: int = 0
    reorder_level: int = 10


class ProductUpdate(BaseModel):
    """Fields a seller may edit. Stock is NOT editable here: it changes
    only through restocking or orders, so every change is accounted for."""

    model_config = ConfigDict(extra="forbid")

    category_id: Optional[int] = None
    product_name: Optional[str] = None
    description: Optional[str] = None
    brand: Optional[str] = None
    price: Optional[Decimal] = None
    reorder_level: Optional[int] = None


class RestockRequest(BaseModel):
    model_config = ConfigDict(extra="forbid")

    quantity: int
