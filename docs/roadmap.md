# Roadmap

## Phase 0 — Architecture
- [x] Product requirements baseline
- [x] Architecture baseline
- [x] AI-agent repository context
- [x] Finalize implementation plan with Copilot

## Phase 0.5 — Foundational Data Decisions
- [x] Amounts as integer minor units (ADR-009)
- [x] Client-generated UUID IDs, UTC epoch-ms timestamps (ADR-010)
- [x] Soft-delete/tombstone strategy defined in `data-model.md`
- [x] No Account/bank-balance entity in v1 — PaymentMethod is a label only (ADR-008)
- [x] Credit-card liability defined as computed, not stored
- [x] Local DB encryption approach decided (SQLCipher, ADR-011)

## Phase 1 — Project Foundation
- [ ] Flutter project
- [ ] Routing/navigation
- [ ] Riverpod
- [ ] Theme/design system
- [ ] Error handling
- [ ] Logging
- [ ] Environment/configuration

## Phase 2 — Authentication
- [ ] Firebase project configuration
- [ ] Firebase App Check configuration (debug provider for local dev)
- [ ] Google Sign-In
- [ ] Auth state
- [ ] User-scoped repositories

## Phase 3 — Local Database
- [ ] Drift database
- [ ] Initial migrations
- [ ] Categories
- [ ] Payment methods
- [ ] Transactions
- [ ] Attachments

## Phase 4 — Transactions
- [ ] Add
- [ ] Edit
- [ ] Delete/archive
- [ ] Search
- [ ] Filtering
- [ ] Validation

## Phase 5 — Credit Cards
- [ ] Multiple cards
- [ ] Billing cycle calculations
- [ ] Liability
- [ ] Bill view
- [ ] Bill payment

## Phase 6 — Cloud Sync
- [ ] Firestore model
- [ ] Sync engine
- [ ] Offline queue
- [ ] Conflict resolution
- [ ] Security Rules

## Phase 7 — Receipts
- [ ] Capture
- [ ] Attachment upload
- [ ] Existing-transaction attachment
- [ ] AI extraction
- [ ] Editable draft

## Phase 8 — AI / Android Integration
- [ ] App Function interface
- [ ] Controlled transaction mutations
- [ ] Read-only financial queries
- [ ] Confirmation flows
- [ ] Platform capability handling

## Phase 9 — Dashboard
- [ ] Spending summary
- [ ] Category chart
- [ ] Payment-method chart
- [ ] Card summary
- [ ] Recent transactions

## Phase 10 — Export
- [ ] CSV
- [ ] XLSX

## Phase 11 — Investments
- [ ] Investment accounts
- [ ] Investment transactions
- [ ] Holdings
- [ ] P&L
- [ ] Dividends
- [ ] Performance
- [ ] Net worth

## Deferred / Not Scheduled
- Recurring transaction definitions (salary, rent, subscriptions) — not in v1 scope; revisit after core transaction flows are stable.
- Bank-account balance tracking (see ADR-008) — only revisit if v1 usage shows it's actually needed.

## Phase 12 — Hardening
- [ ] Security review
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests
- [ ] Offline testing
- [ ] Sync testing
- [ ] AI failure testing
- [ ] Release build
- [ ] Documentation review
