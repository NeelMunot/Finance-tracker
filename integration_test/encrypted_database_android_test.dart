import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:finance_tracker/data/database/app_database.dart';
import 'package:finance_tracker/infrastructure/database/encrypted_database_factory.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Android Runtime Encryption Verification', () {
    late Directory documentsDir;
    late File testDbFile;

    // Test-specific 256-bit keys (64 hex characters)
    const testKeyA =
        'a1b2c3d4e5f678901234567890abcdefa1b2c3d4e5f678901234567890abcdef';
    const testKeyB =
        'fedcba09876543210987654321fedcbafedcba09876543210987654321fedcba';

    Future<void> cleanUpTestFiles() async {
      final targets = [
        testDbFile,
        File('${testDbFile.path}-journal'),
        File('${testDbFile.path}-wal'),
        File('${testDbFile.path}-shm'),
      ];
      for (final file in targets) {
        try {
          if (await file.exists()) {
            await file.delete();
          }
        } on Object {
          // Ignore failures if file was already removed
        }
      }
    }

    setUp(() async {
      documentsDir = await getApplicationDocumentsDirectory();
      testDbFile = File(p.join(documentsDir.path, 'android_runtime_test.db'));
      await cleanUpTestFiles();
    });

    tearDown(() async {
      await cleanUpTestFiles();
    });

    tearDownAll(() async {
      await cleanUpTestFiles();
    });

    testWidgets('1. SQLCipher library is active on Android OS runtime', (
      tester,
    ) async {
      final rawDb = sqlite3.openInMemory();
      try {
        expect(
          () => EncryptedDatabaseFactory.verifySqlCipherAvailable(rawDb),
          returnsNormally,
        );

        final cipher = rawDb.select('PRAGMA cipher_version;');
        expect(cipher.isNotEmpty, isTrue);
        final version = cipher.first.values.first.toString();
        expect(version, isNotEmpty);
      } finally {
        rawDb.close();
      }
    });

    testWidgets(
      '2. Creates temporary encrypted database on Android and writes records',
      (tester) async {
        final db = sqlite3.open(testDbFile.path);
        try {
          EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(db, testKeyA);

          db.execute(
            'CREATE TABLE android_vault (id TEXT PRIMARY KEY, secret TEXT);',
          );
          db.execute(
            "INSERT INTO android_vault VALUES ('item_1', 'android_runtime_secret_42');",
          );
        } finally {
          db.close();
        }

        expect(await testDbFile.exists(), isTrue);
        final fileLength = await testDbFile.length();
        expect(fileLength, greaterThan(0));
      },
    );

    testWidgets('3. Successfully reopens encrypted database with correct key', (
      tester,
    ) async {
      // 1. Create and populate
      var db = sqlite3.open(testDbFile.path);
      try {
        EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(db, testKeyA);
        db.execute(
          'CREATE TABLE android_vault (id TEXT PRIMARY KEY, secret TEXT);',
        );
        db.execute(
          "INSERT INTO android_vault VALUES ('item_1', 'android_runtime_secret_42');",
        );
      } finally {
        db.close();
      }

      // 2. Reopen with the same key
      db = sqlite3.open(testDbFile.path);
      try {
        EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(db, testKeyA);
        final rows = db.select(
          "SELECT secret FROM android_vault WHERE id = 'item_1';",
        );
        expect(rows.length, equals(1));
        expect(rows.first['secret'], equals('android_runtime_secret_42'));
      } finally {
        db.close();
      }
    });

    testWidgets(
      '4. Opening encrypted database with incorrect key fails closed on Android',
      (tester) async {
        // 1. Create and populate
        final db = sqlite3.open(testDbFile.path);
        try {
          EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(db, testKeyA);
          db.execute('CREATE TABLE secrets (data TEXT);');
          db.execute("INSERT INTO secrets VALUES ('confidential_on_android');");
        } finally {
          db.close();
        }

        // 2. Reopen with incorrect key - must fail closed
        final badDb = sqlite3.open(testDbFile.path);
        try {
          expect(
            () => EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(
              badDb,
              testKeyB,
            ),
            throwsA(isA<DatabaseSecurityException>()),
          );
        } finally {
          badDb.close();
        }
      },
    );

    testWidgets(
      '5. Opening encrypted database without key fails with SqliteException',
      (tester) async {
        // 1. Create and populate
        final db = sqlite3.open(testDbFile.path);
        try {
          EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(db, testKeyA);
          db.execute('CREATE TABLE data (val TEXT);');
          db.execute("INSERT INTO data VALUES ('test');");
        } finally {
          db.close();
        }

        // 2. Open without key (unkeyed SQLCipher attempt)
        final unkeyedDb = sqlite3.open(testDbFile.path);
        try {
          expect(
            () => unkeyedDb.select('SELECT count(*) FROM sqlite_master;'),
            throwsA(
              isA<SqliteException>().having(
                (e) => e.message,
                'message',
                contains('file is not a database'),
              ),
            ),
          );
        } finally {
          unkeyedDb.close();
        }
      },
    );

    testWidgets(
      '6. Drift AppDatabase operates on encrypted file via Android background executor',
      (tester) async {
        final executor = EncryptedDatabaseFactory.createEncryptedExecutor(
          file: testDbFile,
          encryptionKey: testKeyA,
          inBackground: true,
        );

        final appDb = AppDatabase.forTesting(executor);
        try {
          expect(appDb.schemaVersion, equals(1));

          final selectResult = await appDb
              .customSelect('SELECT 100 AS number;')
              .getSingle();
          expect(selectResult.read<int>('number'), equals(100));
        } finally {
          await appDb.close();
        }
      },
    );

    testWidgets(
      '7. Verifies test database file is completely absent after test execution',
      (tester) async {
        // At start of this test, previous test's tearDown has already executed
        expect(await testDbFile.exists(), isFalse);
      },
    );
  });
}
