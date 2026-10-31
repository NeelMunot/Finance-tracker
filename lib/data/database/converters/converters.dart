import 'package:drift/drift.dart';

/// Type of category (income or expense).
enum CategoryType { income, expense }

/// Converter for [CategoryType] mapping to uppercase SQLite strings.
class CategoryTypeConverter extends TypeConverter<CategoryType, String> {
  const CategoryTypeConverter();

  @override
  CategoryType fromSql(String fromDb) => switch (fromDb) {
    'INCOME' => CategoryType.income,
    'EXPENSE' => CategoryType.expense,
    _ => throw ArgumentError('Unknown CategoryType in database: $fromDb'),
  };

  @override
  String toSql(CategoryType value) => switch (value) {
    CategoryType.income => 'INCOME',
    CategoryType.expense => 'EXPENSE',
  };
}

/// Kind of payment method label.
enum PaymentMethodKind { cash, bank, creditCard, wallet, other }

/// Converter for [PaymentMethodKind] mapping to uppercase SQLite strings.
class PaymentMethodKindConverter
    extends TypeConverter<PaymentMethodKind, String> {
  const PaymentMethodKindConverter();

  @override
  PaymentMethodKind fromSql(String fromDb) => switch (fromDb) {
    'CASH' => PaymentMethodKind.cash,
    'BANK' => PaymentMethodKind.bank,
    'CREDIT_CARD' => PaymentMethodKind.creditCard,
    'WALLET' => PaymentMethodKind.wallet,
    'OTHER' => PaymentMethodKind.other,
    _ => throw ArgumentError('Unknown PaymentMethodKind in database: $fromDb'),
  };

  @override
  String toSql(PaymentMethodKind value) => switch (value) {
    PaymentMethodKind.cash => 'CASH',
    PaymentMethodKind.bank => 'BANK',
    PaymentMethodKind.creditCard => 'CREDIT_CARD',
    PaymentMethodKind.wallet => 'WALLET',
    PaymentMethodKind.other => 'OTHER',
  };
}

/// Direction driver for transaction entries.
enum TransactionType { income, expense, transfer }

/// Converter for [TransactionType] mapping to uppercase SQLite strings.
class TransactionTypeConverter extends TypeConverter<TransactionType, String> {
  const TransactionTypeConverter();

  @override
  TransactionType fromSql(String fromDb) => switch (fromDb) {
    'INCOME' => TransactionType.income,
    'EXPENSE' => TransactionType.expense,
    'TRANSFER' => TransactionType.transfer,
    _ => throw ArgumentError('Unknown TransactionType in database: $fromDb'),
  };

  @override
  String toSql(TransactionType value) => switch (value) {
    TransactionType.income => 'INCOME',
    TransactionType.expense => 'EXPENSE',
    TransactionType.transfer => 'TRANSFER',
  };
}

/// Audit/source indicator for transactions.
enum TransactionSource { manual, aiReceipt, aiNaturalLanguage, csvImport }

/// Converter for [TransactionSource] mapping to uppercase SQLite strings.
class TransactionSourceConverter
    extends TypeConverter<TransactionSource, String> {
  const TransactionSourceConverter();

  @override
  TransactionSource fromSql(String fromDb) => switch (fromDb) {
    'MANUAL' => TransactionSource.manual,
    'AI_RECEIPT' => TransactionSource.aiReceipt,
    'AI_NATURAL_LANGUAGE' => TransactionSource.aiNaturalLanguage,
    'CSV_IMPORT' => TransactionSource.csvImport,
    _ => throw ArgumentError('Unknown TransactionSource in database: $fromDb'),
  };

  @override
  String toSql(TransactionSource value) => switch (value) {
    TransactionSource.manual => 'MANUAL',
    TransactionSource.aiReceipt => 'AI_RECEIPT',
    TransactionSource.aiNaturalLanguage => 'AI_NATURAL_LANGUAGE',
    TransactionSource.csvImport => 'CSV_IMPORT',
  };
}

/// AI receipt processing status.
enum AiProcessingStatus { notProcessed, pending, done, failed }

/// Converter for [AiProcessingStatus] mapping to uppercase SQLite strings.
class AiProcessingStatusConverter
    extends TypeConverter<AiProcessingStatus, String> {
  const AiProcessingStatusConverter();

  @override
  AiProcessingStatus fromSql(String fromDb) => switch (fromDb) {
    'NOT_PROCESSED' => AiProcessingStatus.notProcessed,
    'PENDING' => AiProcessingStatus.pending,
    'DONE' => AiProcessingStatus.done,
    'FAILED' => AiProcessingStatus.failed,
    _ => throw ArgumentError('Unknown AiProcessingStatus in database: $fromDb'),
  };

  @override
  String toSql(AiProcessingStatus value) => switch (value) {
    AiProcessingStatus.notProcessed => 'NOT_PROCESSED',
    AiProcessingStatus.pending => 'PENDING',
    AiProcessingStatus.done => 'DONE',
    AiProcessingStatus.failed => 'FAILED',
  };
}

/// Synchronization status with Cloud Firestore.
enum SyncStatus { pending, synced, conflict }

/// Converter for [SyncStatus] mapping to lowercase SQLite strings.
class SyncStatusConverter extends TypeConverter<SyncStatus, String> {
  const SyncStatusConverter();

  @override
  SyncStatus fromSql(String fromDb) => switch (fromDb) {
    'pending' => SyncStatus.pending,
    'synced' => SyncStatus.synced,
    'conflict' => SyncStatus.conflict,
    _ => throw ArgumentError('Unknown SyncStatus in database: $fromDb'),
  };

  @override
  String toSql(SyncStatus value) => switch (value) {
    SyncStatus.pending => 'pending',
    SyncStatus.synced => 'synced',
    SyncStatus.conflict => 'conflict',
  };
}
