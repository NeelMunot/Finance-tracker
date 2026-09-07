# Architecture

## Architectural style
Use a layered, feature-oriented Flutter architecture.

```text
Presentation
    -> Application / State
        -> Domain / Business Logic
            -> Repository Interfaces
                -> Data Sources / Persistence
```

## High-level system

```text
                    Android Gemini / AI Agent
                               |
                         App Function
                               |
                               v
Manual Entry ------> Application / Transaction Service <------ Receipt AI Draft
                               |
                               v
                         Drift / SQLite
                               |
                         Synchronization
                               |
                               v
                          Firestore
                               |
                         Firebase Storage
                           (files)
```

## Layer responsibilities

### Presentation
Flutter screens, widgets, navigation and rendering. No business logic.

### Application/state
Riverpod providers/notifiers and orchestration of use cases.

### Domain
Entities, value objects, financial rules, transaction lifecycle, billing-cycle logic, liability calculations and validation.

### Data
Drift, Firestore, Storage, serialization, repositories and synchronization.

### Infrastructure
Firebase initialization, authentication, AI adapters, Android integration, notifications and export.

## Transaction Engine
All transaction mutations converge here.

```text
Manual Entry
       Gemini ----> Transaction Service -> validation -> local DB -> sync
       /
Receipt Draft
```

No feature may create an independent transaction-writing path.

## AI integration
AI is an adapter around application/domain APIs.

AI may:
- parse natural language
- analyze receipts
- produce suggestions
- translate intent to structured commands

AI must not bypass domain validation.

## Sync
Persist locally first for normal offline-first operations, then synchronize to Firestore.

The sync engine handles:
- outbound change tracking
- retry
- remote reconciliation
- conflict handling
- tombstones
- sync status

## Credit cards
Separate:
- expense transaction
- card liability
- bill/payment event

An expense remains categorized as an expense. A card payment reduces liability and does not duplicate the expense.

Liability is **computed at query time** from expense and bill-payment transactions
(see `data-model.md`), not stored as a balance field. This is the only balance-like
computation in the app — see "Scope: no account model" below.

## Scope: no account model
The app does not model bank accounts or generic account-to-account transfers.
`PaymentMethod` is a label; `Transaction.type = TRANSFER` exists only to represent
credit-card bill payments. See ADR-008. Do not introduce an `Account` entity, balance
fields, or reconciliation logic unless a new ADR explicitly changes this.

## Security
- Firebase App Check is configured alongside Authentication (Phase 2), not deferred.
- Local Drift/SQLite database is encrypted at rest (SQLCipher); key lives in platform
  secure storage, never in the database file or source code.
- Firestore/Storage security rules enforce per-user isolation on every collection.

## Storage
Structured metadata belongs in the database/cloud model. Receipt binary files belong in Firebase Storage. Attachment metadata belongs in structured storage.

## Evolution
AI and Android-agent integrations remain behind interfaces so platform changes do not propagate through the core finance domain.
