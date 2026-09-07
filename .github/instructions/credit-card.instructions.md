---
applyTo: "**/*credit_card*/**,**/*credit_card*"
---

# Credit Card Logic Rules

This is the most correctness-sensitive area of the app. Before changing anything here:

1. Re-read the "Credit-card liability" section of `docs/data-model.md`.
2. A card purchase is an `EXPENSE` transaction against a `CREDIT_CARD`-kind payment
   method. It is never a `TRANSFER` and never touches a stored balance.
3. A bill payment is a `TRANSFER` with `isCreditCardBillPayment = true`. It must
   reduce computed liability and must never create a second `EXPENSE` record.
4. Billing-cycle boundaries come from `CreditCard.statementDay`, not the calendar
   month. Boundary dates (the statement day itself, month-end edge cases, cards with
   `statementDay` near 28–31) need explicit unit tests.
5. Any change to liability calculation, cycle math, or bill-payment handling requires
   an accompanying unit test in the same change — do not defer "will add tests
   later" for this feature.
