import 'package:drift/drift.dart';

import '../converters/converters.dart';
import 'categories.dart';
import 'payment_methods.dart';
import 'syncable_table.dart';

/// Transaction records representing income, expenses, and transfers.
@DataClassName('Transaction')
class Transactions extends Table with SyncableTable {
  /// Unique client-generated UUIDv4 identifier.
  TextColumn get id => text()();

  /// Direction driver ('INCOME', 'EXPENSE', 'TRANSFER').
  TextColumn get type => text().map(const TransactionTypeConverter())();

  /// Strictly positive signed 64-bit integer minor currency units (ADR-009).
  IntColumn get amountMinorUnits =>
      integer().customConstraint('NOT NULL CHECK (amount_minor_units > 0)')();

  /// Exactly three uppercase ASCII letters representing ISO 4217 code shape (e.g. 'INR', 'USD').
  TextColumn get currency => text().customConstraint(
    "NOT NULL CHECK (currency GLOB '[A-Z][A-Z][A-Z]')",
  )();

  /// When the spend or receipt happened (user-meaningful UTC epoch ms).
  IntColumn get transactionDate => integer()();

  /// Category reference. Required for INCOME/EXPENSE; null for TRANSFER.
  TextColumn get categoryId => text().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.restrict,
  )();

  /// The 'from' side for EXPENSE/TRANSFER, the 'into' side for INCOME.
  @ReferenceName('transactionsAsPaymentMethod')
  TextColumn get paymentMethodId =>
      text().references(PaymentMethods, #id, onDelete: KeyAction.restrict)();

  /// The 'to' side for TRANSFER.
  @ReferenceName('transactionsAsCounterPaymentMethod')
  TextColumn get counterPaymentMethodId => text().nullable().references(
    PaymentMethods,
    #id,
    onDelete: KeyAction.restrict,
  )();

  /// Optional merchant or payee name.
  TextColumn get merchant => text().nullable()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Optional user notes.
  TextColumn get notes => text().nullable()();

  /// True only for a TRANSFER representing paying down a credit card (ADR-006).
  BoolColumn get isCreditCardBillPayment =>
      boolean().withDefault(const Constant(false))();

  /// Audit/entry source ('MANUAL', 'AI_RECEIPT', 'AI_NATURAL_LANGUAGE', 'CSV_IMPORT').
  TextColumn get source => text()
      .map(const TransactionSourceConverter())
      .withDefault(const Constant('MANUAL'))();

  @override
  Set<Column> get primaryKey => {id};
}
