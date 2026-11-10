"""Request bodies for the ordering endpoints (validation happens here, rules in the database)."""
from typing import Literal, Optional

from pydantic import BaseModel, ConfigDict, Field

PaymentMethod = Literal["UPI", "Credit Card", "Debit Card", "Net Banking", "Wallet"]


class OrderItemIn(BaseModel):
    model_config = ConfigDict(extra="forbid")
    product_id: int
    quantity: int = Field(gt=0, le=1000)


class OrderCreate(BaseModel):
    model_config = ConfigDict(extra="forbid")
    customer_id: int
    address_id: int
    payment_method: PaymentMethod
    items: list[OrderItemIn] = Field(min_length=1, max_length=50)


class PaymentIn(BaseModel):
    model_config = ConfigDict(extra="forbid")
    customer_id: int
    payment_method: Optional[PaymentMethod] = None          # change the method at payment time
    simulate: Optional[Literal["success", "decline", "error"]] = None   # simulated gateway only


class CancelIn(BaseModel):
    model_config = ConfigDict(extra="forbid")
    customer_id: Optional[int] = None                       # omit = admin cancel (no ownership check)
    reason: Optional[str] = Field(default=None, max_length=200)


class ShipmentUpdate(BaseModel):
    model_config = ConfigDict(extra="forbid")
    status: Literal["Shipped", "In Transit", "Delivered"]
    carrier: Optional[str] = Field(default=None, max_length=50)
