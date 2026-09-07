---
applyTo: "lib/domain/**,lib/application/**"
---

# Domain / Application Layer Rules

This code is the transaction engine. Every transaction mutation — manual entry, AI
receipt draft, AI natural-language entry, CSV import — must converge on the same
use-case classes here. Do not let any feature create its own path to persistence.

- Pure, deterministic, unit-testable functions for all financial calculations
  (billing cycles, liability, totals). No Flutter/widget imports in this layer.
- Value objects over primitives: a `Money` type wrapping the integer-minor-units +
  currency pair (ADR-009), not raw `int`/`double` passed around.
- `Transaction.type = TRANSFER` is only ever constructed for credit-card bill
  payments in v1 (see `docs/decisions.md` ADR-008). Do not add general
  account-to-account transfer logic here without a new ADR.
- Credit-card liability is a computed query (see `docs/data-model.md`), not a stored
  field mutated by this layer.
- AI-origin input arrives here already schema-validated, but must still pass full
  domain validation — never treat successful parsing as successful validation.
- Any operation flagged as ambiguous or destructive (delete, large-amount edit,
  credit-card info change) must produce a confirmation requirement the caller can act
  on, not silently apply the change.
