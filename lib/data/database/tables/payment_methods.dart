import 'package:drift/drift.dart';

import '../converters/converters.dart';
import 'credit_cards.dart';
import 'syncable_table.dart';

/// Payment method labels (ADR-008: plain labels, no account balance tracked).
@DataClassName('PaymentMethod')
class PaymentMethods extends Table with SyncableTable {
  /// Unique client-generated UUIDv4 identifier.
  TextColumn get id => text()();

  /// Label name (e.g. "HDFC Savings", "Cash", "Amazon Pay ICICI").
  TextColumn get name => text()();

  /// Kind of payment method ('CASH', 'BANK', 'CREDIT_CARD', 'WALLET', 'OTHER').
  TextColumn get kind => text().map(const PaymentMethodKindConverter())();

  /// Set only when kind = 'CREDIT_CARD'; references CreditCards.id.
  TextColumn get linkedCreditCardId => text().nullable().references(
    CreditCards,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// User-facing archive toggle.
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
