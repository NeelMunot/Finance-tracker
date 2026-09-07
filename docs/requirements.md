# Requirements Baseline

## Product
Personal Finance & Investment Tracker.

## Primary goals
- Fast daily expense/income tracking.
- User-configurable categories and payment methods.
- Multiple credit cards with billing-cycle-aware spending.
- Receipt capture and optional AI extraction.
- Google-account authentication and cross-device synchronization.
- CSV/XLSX export.
- Future investment and portfolio tracking.
- Future natural-language/AI-agent interaction.

## Functional requirements

### Authentication
- Google Sign-In.
- User data isolated by authenticated user identity.
- New device login restores synchronized user data.

### Transactions
- Manual transaction entry.
- Edit/delete transaction.
- Category.
- Payment method.
- Merchant.
- Notes.
- Date/time.
- Amount/currency.
- Attachments.

### Categories
- Add/edit/delete/archive.
- Historical transactions remain valid if a category is retired.

### Payment methods
- Add/edit/delete/archive.
- Credit cards are specialized payment methods.
- **v1 scope:** payment methods are labels only — no bank-account balance is tracked or reconciled. The only balance-like feature is credit-card liability (see below), which is computed rather than stored. See `docs/decisions.md` ADR-008.

### Credit cards
- Multiple cards.
- Credit limit.
- Statement date.
- Due date.
- Billing-cycle-aware spending.
- Outstanding liability.
- Bill composition.
- Bill payment tracking.

### Receipts
- Capture from camera/gallery.
- Store receipt attachment.
- Optionally send to Gemini for extraction.
- AI result becomes an editable draft.
- User can add additional information after scanning.
- Receipt can be attached without AI processing.
- A transaction can support multiple attachments.

### Sync
- Offline-first local operation.
- Automatic cloud synchronization.
- Duplicate prevention.
- Deterministic conflict handling.

### Export
- CSV.
- XLSX.

### Future
- Investment accounts.
- Investment transactions.
- Holdings.
- P&L.
- Dividends.
- Portfolio performance.
- Net worth.
- Android Gemini/App Function integration.

## Non-goals (v1)
- Bank-account balance tracking/reconciliation (see ADR-008).
- Recurring transaction automation.
- Budgets.
- Android App Functions / on-device agent integration (platform feature still in preview).

## Non-functional requirements
- Firebase App Check enabled from initial authentication setup (required for Firebase AI Logic enforcement from Nov 2026 onward).
- Local database encrypted at rest (SQLCipher).
- Secure user data isolation.
- Testable financial calculations.
- Maintainable feature-oriented architecture.
- Clear migration strategy.
- Graceful degradation when AI/network services fail.
- No mandatory AI dependency for ordinary transaction entry.
