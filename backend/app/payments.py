"""Payment gateway abstraction.

The order code only talks to the PaymentGateway interface below. Today the
SimulatedGateway answers instantly; to use a real provider (Razorpay, Stripe...):
  1. write a class with the same two methods (charge, refund) that calls the provider,
  2. add it to GATEWAYS,
  3. set PAYMENT_GATEWAY=<name> in .env.
Nothing in routers/orders.py or in the database changes.
"""
import os
import uuid
from dataclasses import dataclass
from decimal import Decimal
from typing import Optional, Protocol


class GatewayError(Exception):
    """The gateway could not be reached or gave no answer (not the same as a declined card)."""


@dataclass
class ChargeResult:
    success: bool
    transaction_ref: Optional[str] = None
    failure_reason: Optional[str] = None


@dataclass
class RefundResult:
    refund_ref: str


class PaymentGateway(Protocol):
    name: str

    def charge(self, order_id: int, amount: Decimal, method: str,
               simulate: Optional[str] = None) -> ChargeResult: ...

    def refund(self, order_id: int, transaction_ref: Optional[str],
               amount: Decimal) -> RefundResult: ...


class SimulatedGateway:
    """Fake gateway for development and the demo.

    simulate=None or "success" -> approved
    simulate="decline"         -> card declined (the order stays Pending, customer can retry)
    simulate="error"           -> gateway outage (API answers 502, nothing is recorded)
    A real gateway ignores `simulate`.
    """
    name = "simulated"

    def charge(self, order_id, amount, method, simulate=None):
        if simulate == "error":
            raise GatewayError("Simulated gateway outage")
        if simulate == "decline":
            return ChargeResult(False, None, "Payment declined by the bank (simulated)")
        return ChargeResult(True, f"SIM-{order_id}-{uuid.uuid4().hex[:8]}")

    def refund(self, order_id, transaction_ref, amount):
        return RefundResult(f"SIMREF-{order_id}-{uuid.uuid4().hex[:8]}")


GATEWAYS = {"simulated": SimulatedGateway}


def get_gateway() -> PaymentGateway:
    """FastAPI dependency; tests can override it with app.dependency_overrides."""
    name = os.getenv("PAYMENT_GATEWAY", "simulated")
    try:
        return GATEWAYS[name]()
    except KeyError:
        raise RuntimeError(f"Unknown PAYMENT_GATEWAY '{name}'. Known: {', '.join(GATEWAYS)}")
