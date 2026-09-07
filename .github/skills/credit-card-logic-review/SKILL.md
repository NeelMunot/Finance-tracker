---
name: credit-card-logic-review
description: Use as a final check before merging any change that touches credit-card purchases, bill payments, billing cycles, or liability calculations. Catches the most common double-counting and cycle-boundary mistakes in this domain.
---

# Credit Card Logic Review Checklist

Run through this before considering a credit-card-related change done:

- [ ] A purchase is recorded as `EXPENSE`, never `TRANSFER`, and never writes to any
      balance/account field (there isn't one — see ADR-008).
- [ ] A bill payment is recorded as `TRANSFER` with `isCreditCardBillPayment = true`,
      and does **not** also create or modify an `EXPENSE` row for the same amount.
- [ ] Liability for a cycle is computed from transactions at query time, matching the
      formula in `docs/data-model.md` — not read from a cached/stored field that could
      go stale.
- [ ] Billing-cycle boundaries use `CreditCard.statementDay`, tested for: a purchase
      exactly on the statement day, a card with `statementDay` in {29, 30, 31} during
      a shorter month, and a purchase made the day before vs. after the boundary.
- [ ] Unit tests exist for the specific change, not just for the pre-existing
      happy-path cases.
- [ ] If any of the above required a schema or calculation change, `docs/decisions.md`
      and `docs/data-model.md` were updated in the same change, not left stale.
