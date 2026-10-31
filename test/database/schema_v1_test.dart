import 'dart:io';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_tracker/data/database/app_database.dart';
import 'package:finance_tracker/infrastructure/database/encrypted_database_factory.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../fakes/fake_database_key_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late Directory tempDir;
  late FakeDatabaseKeyManager keyManager;
  late AppDatabase db;
  late String dbPath;

  const testUserId = 'test_user_schema_v1';
  final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp(
      'finance_tracker_schema_test_',
    );
    keyManager = FakeDatabaseKeyManager();
    final key = await keyManager.getOrCreateKey(testUserId);
    dbPath = p.join(tempDir.path, 'schema_v1_test.db');

    final executor = EncryptedDatabaseFactory.createEncryptedExecutor(
      file: File(dbPath),
      encryptionKey: key,
      inBackground: false,
    );
    db = AppDatabase.forTesting(executor);
    // Trigger beforeOpen to execute PRAGMA foreign_keys = ON;
    await db.customSelect('SELECT 1;').getSingle();
  });

  tearDown(() async {
    await db.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('Schema Version 1 — Table Existence & Column Structure', () {
    test('all five tables exist in sqlite_master', () async {
      final rows = await db
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name;",
          )
          .get();

      final tableNames = rows.map((r) => r.read<String>('name')).toList();
      expect(
        tableNames,
        containsAll([
          'categories',
          'credit_cards',
          'payment_methods',
          'transactions',
          'attachments',
        ]),
      );
    });

    test(
      'all tables implement uniform SyncableTable metadata columns',
      () async {
        final tables = [
          'categories',
          'credit_cards',
          'payment_methods',
          'transactions',
          'attachments',
        ];

        for (final table in tables) {
          final pragmaColumns = await db
              .customSelect('PRAGMA table_info($table);')
              .get();
          final colNames = pragmaColumns
              .map((r) => r.read<String>('name'))
              .toSet();

          expect(
            colNames,
            contains('created_at'),
            reason: '$table missing created_at',
          );
          expect(
            colNames,
            contains('updated_at'),
            reason: '$table missing updated_at',
          );
          expect(
            colNames,
            contains('deleted_at'),
            reason: '$table missing deleted_at',
          );
          expect(
            colNames,
            contains('sync_status'),
            reason: '$table missing sync_status',
          );
          expect(
            colNames,
            contains('version'),
            reason: '$table missing version',
          );
        }
      },
    );

    test('archive column (active) exists only on Category, CreditCard, and PaymentMethod', () async {
      final hasActive = <String, bool>{};
      for (final table in [
        'categories',
        'credit_cards',
        'payment_methods',
        'transactions',
        'attachments',
      ]) {
        final pragmaColumns = await db
            .customSelect('PRAGMA table_info($table);')
            .get();
        hasActive[table] = pragmaColumns.any(
          (r) => r.read<String>('name') == 'active',
        );
      }

      expect(hasActive['categories'], isTrue);
      expect(hasActive['credit_cards'], isTrue);
      expect(hasActive['payment_methods'], isTrue);
      expect(hasActive['transactions'], isFalse);
      expect(hasActive['attachments'], isFalse);
    });
  });

  group('Schema Version 1 — Enum Serialization & Deserialization', () {
    test(
      'TypeConverters map strictly to exact documented database strings',
      () {
        const catConv = CategoryTypeConverter();
        expect(catConv.toSql(CategoryType.income), equals('INCOME'));
        expect(catConv.toSql(CategoryType.expense), equals('EXPENSE'));
        expect(catConv.fromSql('INCOME'), equals(CategoryType.income));
        expect(catConv.fromSql('EXPENSE'), equals(CategoryType.expense));
        expect(() => catConv.fromSql('income'), throwsArgumentError);

        const pmConv = PaymentMethodKindConverter();
        expect(pmConv.toSql(PaymentMethodKind.cash), equals('CASH'));
        expect(pmConv.toSql(PaymentMethodKind.bank), equals('BANK'));
        expect(
          pmConv.toSql(PaymentMethodKind.creditCard),
          equals('CREDIT_CARD'),
        );
        expect(pmConv.toSql(PaymentMethodKind.wallet), equals('WALLET'));
        expect(pmConv.toSql(PaymentMethodKind.other), equals('OTHER'));
        expect(
          pmConv.fromSql('CREDIT_CARD'),
          equals(PaymentMethodKind.creditCard),
        );
        expect(() => pmConv.fromSql('creditCard'), throwsArgumentError);

        const txConv = TransactionTypeConverter();
        expect(txConv.toSql(TransactionType.income), equals('INCOME'));
        expect(txConv.toSql(TransactionType.expense), equals('EXPENSE'));
        expect(txConv.toSql(TransactionType.transfer), equals('TRANSFER'));
        expect(txConv.fromSql('TRANSFER'), equals(TransactionType.transfer));
        expect(() => txConv.fromSql('transfer'), throwsArgumentError);

        const srcConv = TransactionSourceConverter();
        expect(srcConv.toSql(TransactionSource.manual), equals('MANUAL'));
        expect(
          srcConv.toSql(TransactionSource.aiReceipt),
          equals('AI_RECEIPT'),
        );
        expect(
          srcConv.toSql(TransactionSource.aiNaturalLanguage),
          equals('AI_NATURAL_LANGUAGE'),
        );
        expect(
          srcConv.toSql(TransactionSource.csvImport),
          equals('CSV_IMPORT'),
        );
        expect(
          srcConv.fromSql('AI_RECEIPT'),
          equals(TransactionSource.aiReceipt),
        );
        expect(() => srcConv.fromSql('manual'), throwsArgumentError);

        const aiConv = AiProcessingStatusConverter();
        expect(
          aiConv.toSql(AiProcessingStatus.notProcessed),
          equals('NOT_PROCESSED'),
        );
        expect(aiConv.toSql(AiProcessingStatus.pending), equals('PENDING'));
        expect(aiConv.toSql(AiProcessingStatus.done), equals('DONE'));
        expect(aiConv.toSql(AiProcessingStatus.failed), equals('FAILED'));
        expect(aiConv.fromSql('DONE'), equals(AiProcessingStatus.done));
        expect(() => aiConv.fromSql('done'), throwsArgumentError);

        const syncConv = SyncStatusConverter();
        expect(syncConv.toSql(SyncStatus.pending), equals('pending'));
        expect(syncConv.toSql(SyncStatus.synced), equals('synced'));
        expect(syncConv.toSql(SyncStatus.conflict), equals('conflict'));
        expect(syncConv.fromSql('pending'), equals(SyncStatus.pending));
        expect(() => syncConv.fromSql('PENDING'), throwsArgumentError);
      },
    );

    test('companion inserts store exact raw strings in SQLite', () async {
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: 'cat-1',
              name: 'Groceries',
              type: CategoryType.expense,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      final rawCat = await db
          .customSelect(
            "SELECT type, sync_status FROM categories WHERE id = 'cat-1';",
          )
          .getSingle();
      expect(rawCat.read<String>('type'), equals('EXPENSE'));
      expect(rawCat.read<String>('sync_status'), equals('pending'));
    });
  });

  group('Schema Version 1 — Default Values on Insertion', () {
    test('omitted default columns store expected values in SQLite', () async {
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              id: 'cat-default-test',
              name: 'Salary',
              type: CategoryType.income,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      await db
          .into(db.paymentMethods)
          .insert(
            PaymentMethodsCompanion.insert(
              id: 'pm-default-test',
              name: 'Cash In Hand',
              kind: PaymentMethodKind.cash,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: 'tx-default-test',
              type: TransactionType.income,
              amountMinorUnits: 500000,
              currency: 'INR',
              transactionDate: nowMs,
              paymentMethodId: 'pm-default-test',
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      // Verify category defaults
      final catRow = await db
          .customSelect(
            "SELECT sync_status, version, active FROM categories WHERE id = 'cat-default-test';",
          )
          .getSingle();
      expect(catRow.read<String>('sync_status'), equals('pending'));
      expect(catRow.read<int>('version'), equals(1));
      expect(catRow.read<int>('active'), equals(1));

      // Verify transaction defaults
      final txRow = await db
          .customSelect(
            "SELECT sync_status, version, source, is_credit_card_bill_payment FROM transactions WHERE id = 'tx-default-test';",
          )
          .getSingle();
      expect(txRow.read<String>('sync_status'), equals('pending'));
      expect(txRow.read<int>('version'), equals(1));
      expect(txRow.read<String>('source'), equals('MANUAL'));
      expect(txRow.read<int>('is_credit_card_bill_payment'), equals(0));
    });
  });

  group('Schema Version 1 — SQLite DDL Constraints & Engine Enforcement', () {
    test('Transaction amountMinorUnits must be strictly positive', () async {
      await db
          .into(db.paymentMethods)
          .insert(
            PaymentMethodsCompanion.insert(
              id: 'pm-tx-const',
              name: 'Bank',
              kind: PaymentMethodKind.bank,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      // Zero amount should fail SQLite CHECK (amount_minor_units > 0)
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-zero', 'EXPENSE', 0, 'INR', $nowMs, 'pm-tx-const', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Negative amount should fail SQLite CHECK (amount_minor_units > 0)
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-neg', 'EXPENSE', -500, 'INR', $nowMs, 'pm-tx-const', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Positive amount should succeed
      await db.customStatement(
        "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
        "VALUES ('tx-pos', 'EXPENSE', 100, 'INR', $nowMs, 'pm-tx-const', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
      );
    });

    test('Transaction currency must be exactly 3 uppercase ASCII letters', () async {
      await db
          .into(db.paymentMethods)
          .insert(
            PaymentMethodsCompanion.insert(
              id: 'pm-curr-test',
              name: 'Bank',
              kind: PaymentMethodKind.bank,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      // Lowercase rejected
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-c1', 'EXPENSE', 100, 'inr', $nowMs, 'pm-curr-test', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Length 2 rejected
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-c2', 'EXPENSE', 100, 'US', $nowMs, 'pm-curr-test', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Length 4 rejected
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-c3', 'EXPENSE', 100, 'USDT', $nowMs, 'pm-curr-test', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Numbers rejected
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-c4', 'EXPENSE', 100, 'U1D', $nowMs, 'pm-curr-test', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Valid 3 uppercase ASCII accepted
      await db.customStatement(
        "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
        "VALUES ('tx-c5', 'EXPENSE', 100, 'USD', $nowMs, 'pm-curr-test', $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
      );
    });

    test('CreditCard statementDay and dueDay must be between 1 and 31', () async {
      // statementDay = 0 rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-1', 'Card', 'Bank', 0, 15, 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // statementDay = 32 rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-2', 'Card', 'Bank', 32, 15, 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // dueDay = 0 rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-3', 'Card', 'Bank', 10, 0, 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Valid boundaries 1 and 31 accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-4', 'Card', 'Bank', 1, 31, 1, $nowMs, $nowMs, 'pending', 1);",
      );
    });

    test('CreditCard creditLimitMinorUnits allows NULL and non-negative values, rejects negative', () async {
      // Negative limit rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, credit_limit_minor_units, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-lim-neg', 'Card', 'Bank', 1, 15, -1, 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Zero accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, credit_limit_minor_units, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-lim-zero', 'Card', 'Bank', 1, 15, 0, 1, $nowMs, $nowMs, 'pending', 1);",
      );

      // Positive accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, credit_limit_minor_units, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-lim-pos', 'Card', 'Bank', 1, 15, 15000000, 1, $nowMs, $nowMs, 'pending', 1);",
      );

      // NULL accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, credit_limit_minor_units, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-lim-null', 'Card', 'Bank', 1, 15, NULL, 1, $nowMs, $nowMs, 'pending', 1);",
      );
    });

    test('CreditCard lastFourDigits allows NULL and exactly 4 digits, rejects invalid shapes', () async {
      // 3 digits rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-d1', 'Card', 'Bank', 1, 15, '123', 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // 5 digits rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-d2', 'Card', 'Bank', 1, 15, '12345', 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Alpha characters rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-d3', 'Card', 'Bank', 1, 15, '12a4', 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Spaces rejected
      expect(
        () => db.customStatement(
          "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
          "VALUES ('cc-d4', 'Card', 'Bank', 1, 15, ' 123', 1, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Exactly 4 digits accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-d5', 'Card', 'Bank', 1, 15, '5678', 1, $nowMs, $nowMs, 'pending', 1);",
      );

      // NULL accepted
      await db.customStatement(
        "INSERT INTO credit_cards (id, name, issuer, statement_day, due_day, last_four_digits, active, created_at, updated_at, sync_status, version) "
        "VALUES ('cc-d6', 'Card', 'Bank', 1, 15, NULL, 1, $nowMs, $nowMs, 'pending', 1);",
      );
    });

    test('NOT NULL constraints are enforced by SQLite engine', () async {
      // Categories.name NOT NULL
      expect(
        () => db.customStatement(
          "INSERT INTO categories (id, name, type, created_at, updated_at, sync_status, version, active) "
          "VALUES ('cat-null', NULL, 'INCOME', $nowMs, $nowMs, 'pending', 1, 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Transactions.payment_method_id NOT NULL
      expect(
        () => db.customStatement(
          "INSERT INTO transactions (id, type, amount_minor_units, currency, transaction_date, payment_method_id, created_at, updated_at, sync_status, version, is_credit_card_bill_payment, source) "
          "VALUES ('tx-null-pm', 'EXPENSE', 100, 'INR', $nowMs, NULL, $nowMs, $nowMs, 'pending', 1, 0, 'MANUAL');",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );

      // Attachments.storage_path NOT NULL
      expect(
        () => db.customStatement(
          "INSERT INTO attachments (id, transaction_id, storage_path, file_name, mime_type, size_bytes, created_at, updated_at, sync_status, version) "
          "VALUES ('att-null-path', 'tx-pos', NULL, 'receipt.jpg', 'image/jpeg', 1024, $nowMs, $nowMs, 'pending', 1);",
        ),
        throwsA(isA<sqlite.SqliteException>()),
      );
    });
  });

  group('Schema Version 1 — Foreign Key Referential Integrity', () {
    test(
      'PaymentMethod linkedCreditCardId SET NULL on card deletion',
      () async {
        // 1. Insert parent CreditCard
        await db
            .into(db.creditCards)
            .insert(
              CreditCardsCompanion.insert(
                id: 'card-fk-1',
                name: 'Millennia',
                issuer: 'HDFC',
                statementDay: 15,
                dueDay: 5,
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // 2. Insert child PaymentMethod referencing card
        await db
            .into(db.paymentMethods)
            .insert(
              PaymentMethodsCompanion.insert(
                id: 'pm-fk-1',
                name: 'HDFC Millennia',
                kind: PaymentMethodKind.creditCard,
                linkedCreditCardId: const Value('card-fk-1'),
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // Inserting with invalid card ID fails
        expect(
          () => db
              .into(db.paymentMethods)
              .insert(
                PaymentMethodsCompanion.insert(
                  id: 'pm-fk-bad',
                  name: 'Bad Card PM',
                  kind: PaymentMethodKind.creditCard,
                  linkedCreditCardId: const Value('non-existent-card'),
                  createdAt: nowMs,
                  updatedAt: nowMs,
                ),
              ),
          throwsA(isA<sqlite.SqliteException>()),
        );

        // 3. Delete parent CreditCard
        await (db.delete(
          db.creditCards,
        )..where((c) => c.id.equals('card-fk-1'))).go();

        // 4. Verify linkedCreditCardId became NULL via ON DELETE SET NULL
        final pm = await (db.select(
          db.paymentMethods,
        )..where((p) => p.id.equals('pm-fk-1'))).getSingle();
        expect(pm.linkedCreditCardId, isNull);
      },
    );

    test(
      'Transaction foreign keys RESTRICT on referenced parent deletion',
      () async {
        // Insert parents
        await db
            .into(db.categories)
            .insert(
              CategoriesCompanion.insert(
                id: 'cat-restrict-1',
                name: 'Dining',
                type: CategoryType.expense,
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );
        await db
            .into(db.paymentMethods)
            .insert(
              PaymentMethodsCompanion.insert(
                id: 'pm-restrict-1',
                name: 'UPI Bank',
                kind: PaymentMethodKind.bank,
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // Insert transaction referencing category and payment method
        await db
            .into(db.transactions)
            .insert(
              TransactionsCompanion.insert(
                id: 'tx-restrict-1',
                type: TransactionType.expense,
                amountMinorUnits: 45000,
                currency: 'INR',
                transactionDate: nowMs,
                categoryId: const Value('cat-restrict-1'),
                paymentMethodId: 'pm-restrict-1',
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // Attempting to delete referenced Category throws SqliteException (RESTRICT)
        expect(
          () => (db.delete(
            db.categories,
          )..where((c) => c.id.equals('cat-restrict-1'))).go(),
          throwsA(isA<sqlite.SqliteException>()),
        );

        // Attempting to delete referenced PaymentMethod throws SqliteException (RESTRICT)
        expect(
          () => (db.delete(
            db.paymentMethods,
          )..where((p) => p.id.equals('pm-restrict-1'))).go(),
          throwsA(isA<sqlite.SqliteException>()),
        );
      },
    );

    test('Attachment transactionId CASCADE deletes row on physical transaction delete', () async {
      await db
          .into(db.paymentMethods)
          .insert(
            PaymentMethodsCompanion.insert(
              id: 'pm-cascade-1',
              name: 'Cash',
              kind: PaymentMethodKind.cash,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: 'tx-cascade-1',
              type: TransactionType.expense,
              amountMinorUnits: 20000,
              currency: 'INR',
              transactionDate: nowMs,
              paymentMethodId: 'pm-cascade-1',
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      await db
          .into(db.attachments)
          .insert(
            AttachmentsCompanion.insert(
              id: 'att-cascade-1',
              transactionId: 'tx-cascade-1',
              storagePath: 'users/test/receipts/r1.jpg',
              fileName: 'r1.jpg',
              mimeType: 'image/jpeg',
              sizeBytes: 204800,
              createdAt: nowMs,
              updatedAt: nowMs,
            ),
          );

      // Verify attachment exists
      final attBefore = await (db.select(
        db.attachments,
      )..where((a) => a.id.equals('att-cascade-1'))).getSingleOrNull();
      expect(attBefore, isNotNull);

      // Physically delete parent transaction
      await (db.delete(
        db.transactions,
      )..where((t) => t.id.equals('tx-cascade-1'))).go();

      // Verify attachment was CASCADE deleted
      final attAfter = await (db.select(
        db.attachments,
      )..where((a) => a.id.equals('att-cascade-1'))).getSingleOrNull();
      expect(attAfter, isNull);
    });
  });

  group('Schema Version 1 — SQLCipher Encryption & Per-User Isolation', () {
    test(
      'database file on disk is encrypted and unreadable by plaintext SQLite',
      () {
        final plainDb = sqlite.sqlite3.open(dbPath);
        try {
          expect(
            () => plainDb.select('SELECT count(*) FROM sqlite_master;'),
            throwsA(
              isA<sqlite.SqliteException>().having(
                (e) => e.message,
                'message',
                contains('file is not a database'),
              ),
            ),
          );
        } finally {
          plainDb.close();
        }
      },
    );

    test('User A database and User B database are isolated', () async {
      final userBId = 'test_user_schema_v1_b';
      final keyB = await keyManager.getOrCreateKey(userBId);
      final dbPathB = p.join(tempDir.path, 'schema_v1_user_b.db');

      final executorB = EncryptedDatabaseFactory.createEncryptedExecutor(
        file: File(dbPathB),
        encryptionKey: keyB,
        inBackground: false,
      );
      final dbB = AppDatabase.forTesting(executorB);

      try {
        // Insert category in db (User A)
        await db
            .into(db.categories)
            .insert(
              CategoriesCompanion.insert(
                id: 'cat-user-a',
                name: 'Alice Category',
                type: CategoryType.income,
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // Insert category in dbB (User B)
        await dbB
            .into(db.categories)
            .insert(
              CategoriesCompanion.insert(
                id: 'cat-user-b',
                name: 'Bob Category',
                type: CategoryType.expense,
                createdAt: nowMs,
                updatedAt: nowMs,
              ),
            );

        // Verify User A only sees Alice's row
        final catsA = await db.select(db.categories).get();
        expect(catsA.any((c) => c.id == 'cat-user-a'), isTrue);
        expect(catsA.any((c) => c.id == 'cat-user-b'), isFalse);

        // Verify User B only sees Bob's row
        final catsB = await dbB.select(dbB.categories).get();
        expect(catsB.any((c) => c.id == 'cat-user-b'), isTrue);
        expect(catsB.any((c) => c.id == 'cat-user-a'), isFalse);
      } finally {
        await dbB.close();
      }
    });
  });
}
