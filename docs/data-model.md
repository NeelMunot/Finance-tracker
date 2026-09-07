# Data Model (v1 — Concrete Baseline)

Status: Decided for v1. Changes to types/keys below require an ADR in `decisions.md`, not a silent edit during coding.

## v1 scope decision

**No `Account`/bank-balance entity exists in v1.** `PaymentMethod` is a plain label
(cash, a specific bank, a specific credit card, a wallet app, etc.) with **no balance
tracked against it**. The app is a transaction log, not a ledger with account balances.

The one exception is **credit cards**, which are a first-class requirement (billing
cycles, liability, bill payments) and are handled without needing a generic Account
entity — see "Credit card liability" below. If real bank-account balance tracking is
wanted later, it is a deliberate v2 addition (new entity + migration), not an implicit
side effect of Transfer.

## Global conventions (decided, not to be re-guessed per feature)

| Concern | Decision |
|---|---|
| IDs | UUIDv4 string, generated client-side at creation time (`uuid` package). Never auto-increment ints. |
| Money amounts | Signed 64-bit integer, **minor units** (e.g. paise, cents). Never `double`/floating point. A `currency` field (ISO 4217, e.g. `"INR"`) travels with every amount. |
| Timestamps | Stored as UTC epoch milliseconds (`int`). Convert to local time only in the presentation layer. `transactionDate` is a user-meaningful date/time (when the spend happened); `createdAt`/`updatedAt` are record bookkeeping timestamps and can differ from it (e.g. backdated entry). |
| Soft delete | Every mutable entity has a nullable `deletedAt`. Deletes are tombstones, not row removal, so sync can propagate them. Rows with `deletedAt != null` are excluded from all normal queries via the repository layer, never filtered ad hoc in UI/widget code. |
| Sync metadata | Every syncable entity carries `updatedAt`, `syncStatus` (`pending` / `synced` / `conflict`), and an integer `version` incremented on every local mutation. |
| Local DB encryption | Local SQLite file is encrypted via SQLCipher (`sqlcipher_flutter_libs` + Drift's SQLCipher support), key sourced from platform secure storage (Keystore/Keychain via `flutter_secure_storage`). Decided now because this financial data doesn't belong in a plaintext file on device — implement it when Drift is first wired up in Phase 3, not retrofitted later. |

## Core entities

### Category
| Field | Type | Notes |
|---|---|---|
| id | uuid |  |
| name | text |  |
| type | enum: `INCOME`, `EXPENSE` | A category belongs to one side; do not reuse across both. |
| icon | text, nullable |  |
| color | text, nullable | Hex string |
| active | bool | Archiving, not deleting, keeps historical transactions valid. |
| createdAt / updatedAt | epoch ms |  |

### PaymentMethod
| Field | Type | Notes |
|---|---|---|
| id | uuid |  |
| name | text | e.g. "HDFC Savings", "Cash", "Amazon Pay" |
| kind | enum: `CASH`, `BANK`, `CREDIT_CARD`, `WALLET`, `OTHER` |  |
| linkedCreditCardId | uuid, nullable | Set only when `kind = CREDIT_CARD`; points to `CreditCard`. |
| active | bool |  |
| createdAt / updatedAt | epoch ms |  |

No balance field. This is intentionally just a label plus a `kind` for filtering/reporting.

### CreditCard
| Field | Type | Notes |
|---|---|---|
| id | uuid |  |
| name | text |  |
| issuer | text |  |
| lastFourDigits | text, nullable |  |
| creditLimitMinorUnits | int, nullable |  |
| statementDay | int (1–31) | Day of month the statement is generated. |
| dueDay | int (1–31) | Day of month payment is due (may roll to next month). |
| active | bool |  |
| createdAt / updatedAt | epoch ms |  |

### Transaction
| Field | Type | Notes |
|---|---|---|
| id | uuid |  |
| type | enum: `INCOME`, `EXPENSE`, `TRANSFER` | See "Transaction types" below. |
| amountMinorUnits | int | Always positive; sign/direction comes from `type`, never from the number. |
| currency | text (ISO 4217) |  |
| transactionDate | epoch ms | When the spend/receipt happened (user-editable, can be backdated). |
| categoryId | uuid, nullable | Required for `INCOME`/`EXPENSE`; null for `TRANSFER`. |
| paymentMethodId | uuid | The "from" side for EXPENSE/TRANSFER, the "into" side for INCOME. |
| counterPaymentMethodId | uuid, nullable | Only set for `TRANSFER` (including credit-card bill payments) — the "to" side. |
| merchant | text, nullable |  |
| description | text, nullable |  |
| notes | text, nullable |  |
| isCreditCardBillPayment | bool | True only for a `TRANSFER` that represents paying down a card. Drives the liability calculation below; see `decisions.md` ADR-010. |
| source | enum: `MANUAL`, `AI_RECEIPT`, `AI_NATURAL_LANGUAGE`, `CSV_IMPORT` | For audit/debug only — never used to bypass validation. |
| createdAt / updatedAt / deletedAt | epoch ms, deletedAt nullable |  |
| syncStatus / version | see global conventions |  |

### Attachment
| Field | Type | Notes |
|---|---|---|
| id | uuid |  |
| transactionId | uuid |  |
| storagePath | text | Firebase Storage path. |
| fileName | text |  |
| mimeType | text |  |
| sizeBytes | int |  |
| aiProcessingStatus | enum, nullable: `NOT_PROCESSED`, `PENDING`, `DONE`, `FAILED` |  |
| createdAt / updatedAt | epoch ms |  |

### Future (deferred, not built in v1)
`InvestmentAccount`, `InvestmentTransaction` (BUY/SELL/DIVIDEND/BONUS/SPLIT/FEE) — kept out of scope; when built, they get their own entities rather than being forced into `Transaction`.

## Transaction types, explained

- **INCOME**: increases nothing on the liability side; just a positive record against `paymentMethodId`.
- **EXPENSE**: a normal spend against `paymentMethodId`. If `paymentMethodId` resolves to a `CREDIT_CARD` payment method, this expense also counts toward that card's liability (computed, see below) — it does **not** get double-recorded anywhere else.
- **TRANSFER**: movement between two payment-method labels with **no income/expense effect** and **no account balance to update** (since none are tracked). The only meaningful use of `TRANSFER` in v1 is a **credit-card bill payment**: `paymentMethodId` = bank/cash, `counterPaymentMethodId` = the credit card, `isCreditCardBillPayment = true`. This is excluded from spending totals and reduces the card's computed liability.

## Credit-card liability (computed, not stored)

There is no `balance` column anywhere. A card's outstanding liability for a billing
cycle is always **derived** at query time:

```text
liability(card, cycle) =
    sum(EXPENSE.amount where paymentMethodId → this card, transactionDate in cycle)
  - sum(TRANSFER.amount where isCreditCardBillPayment = true
        and counterPaymentMethodId = this card, transactionDate in cycle or later)
```

This keeps the whole feature (a hard requirement) without introducing generic
account-balance machinery anywhere else in the app. Billing-cycle boundaries come from
`CreditCard.statementDay`; this calculation must be unit-tested (see non-negotiable rule
about billing-cycle tests).

## Relationships

```text
Category (INCOME/EXPENSE) ─┐
PaymentMethod ──────────────┼──> Transaction ──> Attachment (0..n)
CreditCard (via PaymentMethod.linkedCreditCardId)
```

No `User → Accounts` tree. Everything is scoped to the authenticated user at the
repository/query level (`WHERE userId = currentUser`), not via a separate Account
hierarchy.
