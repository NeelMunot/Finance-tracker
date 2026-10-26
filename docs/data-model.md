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
| Soft delete | Every mutable entity (`Category`, `PaymentMethod`, `CreditCard`, `Transaction`, `Attachment`) has a nullable `deletedAt: int?` (UTC epoch ms). Deletes are tombstones, not row removal, so sync can propagate them. Rows with `deletedAt != null` are excluded from all normal queries via the repository layer, never filtered ad hoc in UI/widget code. Distinct from `active: bool` (archive toggle). |
| Sync metadata | Every syncable entity carries `createdAt` (epoch ms), `updatedAt` (epoch ms), `deletedAt` (nullable epoch ms), `syncStatus` (`pending` / `synced` / `conflict`, default `'pending'`), and an integer `version` incremented on every local mutation (default `1`). |
| Local DB encryption & User Isolation | The local SQLite database is encrypted via SQLCipher using `package:sqlite3` build hooks (`hooks.user_defines.sqlite3.source: sqlcipher`), with a unique 256-bit passphrase per user stored in platform secure storage (`flutter_secure_storage`). Isolation is per-user at the database instance level (`app_user_<hash>.db`), where `<hash>` is a filesystem-safe SHA-256 hash prefix of the user ID. Entity tables do not contain redundant `userId` columns. The database fails closed if it cannot be verified or decrypted (no plaintext fallback). Local databases and secure storage keys must be excluded from OS-level auto-backup (restoration across devices is handled by Cloud Firestore in Phase 6). |

## Core entities

### Category
| Field | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| name | text | e.g. "Groceries", "Salary" |
| type | enum: `INCOME`, `EXPENSE` | A category belongs to one side; do not reuse across both. |
| icon | text, nullable | Icon identifier |
| color | text, nullable | Hex color string |
| active | bool | User-facing archive toggle. Archiving preserves historical transactions while hiding from pickers. |
| createdAt / updatedAt | epoch ms | Non-nullable audit timestamps |
| deletedAt | epoch ms, nullable | Soft-delete tombstone. Null if active/archived; timestamp if deleted. |
| syncStatus / version | enum/text, int | Sync metadata: `pending`/`synced`/`conflict`, integer mutation version. |

### PaymentMethod
| Field | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| name | text | e.g. "HDFC Savings", "Cash", "Amazon Pay ICICI" |
| kind | enum: `CASH`, `BANK`, `CREDIT_CARD`, `WALLET`, `OTHER` |  |
| linkedCreditCardId | uuid, nullable | Set only when `kind = CREDIT_CARD`; foreign key pointing to `CreditCard.id`. |
| active | bool | User-facing archive toggle. |
| createdAt / updatedAt | epoch ms | Non-nullable audit timestamps |
| deletedAt | epoch ms, nullable | Soft-delete tombstone. |
| syncStatus / version | enum/text, int | Sync metadata: `pending`/`synced`/`conflict`, integer mutation version. |

No balance field. This is intentionally just a label plus a `kind` for filtering/reporting.

### CreditCard
The `CreditCard` entity represents a **financial tracking and liability profile**, not a payment credential or instrument.
- **Privacy & credential prohibition:** V1 must never collect or store full primary account numbers (PAN), CVV/CVC, PINs, OTPs, or online banking credentials. CVV/CVC must never be stored under any circumstances.
- Tracking cards is optional; the app functions fully without credit cards.
- The `CreditCard` table is provisioned in Phase 3 as schema-only infrastructure (so `PaymentMethod.linkedCreditCardId` has foreign-key integrity); domain logic, billing cycle math, liability calculations, and UI are deferred to Phase 5.
- Reminder preferences are intentionally deferred from the v1 schema until a dedicated notification feature is designed in a future phase.

| Field | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| name | text | User-defined nickname (e.g. "Millennia", "Amazon Pay ICICI") |
| issuer | text | Bank or institution (e.g. "HDFC Bank", "ICICI") |
| lastFourDigits | text, nullable | Optional display label for distinguishing cards; **never required**. |
| creditLimitMinorUnits | int, nullable | Optional credit limit in minor currency units. |
| statementDay | int (1–31) | Day of month the statement is generated / cycle closes. |
| dueDay | int (1–31) | Day of month payment is due (may roll to next month). |
| active | bool | User-facing archive toggle. |
| createdAt / updatedAt | epoch ms | Non-nullable audit timestamps |
| deletedAt | epoch ms, nullable | Soft-delete tombstone. |
| syncStatus / version | enum/text, int | Sync metadata: `pending`/`synced`/`conflict`, integer mutation version. |

### Transaction
| Field | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| type | enum: `INCOME`, `EXPENSE`, `TRANSFER` | See "Transaction types" below. |
| amountMinorUnits | int | Always positive; sign/direction comes from `type`, never from the number. |
| currency | text (ISO 4217) | e.g. "INR", "USD" |
| transactionDate | epoch ms | When the spend/receipt happened (user-editable, can be backdated). |
| categoryId | uuid, nullable | Required for `INCOME`/`EXPENSE`; null for `TRANSFER`. References `Category.id`. |
| paymentMethodId | uuid | The "from" side for EXPENSE/TRANSFER, the "into" side for INCOME. References `PaymentMethod.id`. |
| counterPaymentMethodId | uuid, nullable | Only set for `TRANSFER` (including credit-card bill payments) — the "to" side. References `PaymentMethod.id`. |
| merchant | text, nullable | Optional merchant/payee name |
| description | text, nullable | Optional description |
| notes | text, nullable | Optional notes |
| isCreditCardBillPayment | bool | True only for a `TRANSFER` that represents paying down a card. Drives the liability calculation below; see `decisions.md` ADR-010. |
| source | enum: `MANUAL`, `AI_RECEIPT`, `AI_NATURAL_LANGUAGE`, `CSV_IMPORT` | For audit/debug only — never used to bypass validation. |
| createdAt / updatedAt | epoch ms | Non-nullable audit timestamps |
| deletedAt | epoch ms, nullable | Soft-delete tombstone. |
| syncStatus / version | enum/text, int | Sync metadata: `pending`/`synced`/`conflict`, integer mutation version. |

### Attachment
| Field | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| transactionId | uuid | Foreign key referencing `Transaction.id`. |
| storagePath | text | Firebase Storage path. |
| fileName | text | Original file name |
| mimeType | text | e.g. "image/jpeg", "application/pdf" |
| sizeBytes | int | File size |
| aiProcessingStatus | enum, nullable: `NOT_PROCESSED`, `PENDING`, `DONE`, `FAILED` | AI receipt extraction status |
| createdAt / updatedAt | epoch ms | Non-nullable audit timestamps |
| deletedAt | epoch ms, nullable | Soft-delete tombstone. Propagates remote storage deletion in Phase 6. |
| syncStatus / version | enum/text, int | Sync metadata: `pending`/`synced`/`conflict`, integer mutation version. |

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

## Relationships & Isolation

```text
Category (INCOME/EXPENSE) ─┐
PaymentMethod ──────────────┼──> Transaction ──> Attachment (0..n)
CreditCard (via PaymentMethod.linkedCreditCardId)
```

No `User → Accounts` tree. User data isolation is enforced at the database instance level via `UserScope`: each authenticated user operates against their own SQLCipher-encrypted database instance (`app_user_<hash>.db`), eliminating the risk of cross-user data leakage and avoiding redundant `userId` columns in the tables.
