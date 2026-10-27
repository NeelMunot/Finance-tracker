import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_tracker/application/auth/auth_providers.dart';
import 'package:finance_tracker/application/database/database_providers.dart';
import 'package:finance_tracker/data/database/app_database.dart';
import 'package:finance_tracker/domain/auth/user_scope.dart';
import 'package:finance_tracker/infrastructure/database/encrypted_database_factory.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../fakes/fake_database_key_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late FakeDatabaseKeyManager keyManager;

  const userA = 'user_alice_123';
  const userB = 'user_bob_456';

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('finance_tracker_db_test_');
    keyManager = FakeDatabaseKeyManager();
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('EncryptedDatabaseFactory & SQLCipher Verification', () {
    test('SQLCipher is active and returns a non-empty cipher_version', () {
      final rawDb = sqlite3.openInMemory();
      try {
        expect(
          () => EncryptedDatabaseFactory.verifySqlCipherAvailable(rawDb),
          returnsNormally,
        );

        final cipher = rawDb.select('PRAGMA cipher_version;');
        expect(cipher.isNotEmpty, isTrue);
        expect(cipher.first.values.first.toString(), isNotEmpty);
      } finally {
        rawDb.close();
      }
    });

    test('validates 256-bit hexadecimal key format strictly', () {
      final rawDb = sqlite3.openInMemory();
      try {
        expect(
          () => EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(
            rawDb,
            'too-short-key',
          ),
          throwsA(isA<DatabaseSecurityException>()),
        );

        expect(
          () => EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(
            rawDb,
            'g' * 64, // 'g' is not hex
          ),
          throwsA(isA<DatabaseSecurityException>()),
        );
      } finally {
        rawDb.close();
      }
    });

    test(
      'creates encrypted database, reopens with same key, and persists data',
      () async {
        final dbFile = File(p.join(tempDir.path, 'encrypted_test.db'));
        final key = await keyManager.getOrCreateKey(userA);

        // 1. Create and write data using raw encrypted connection
        final rawDb = sqlite3.open(dbFile.path);
        EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(rawDb, key);
        rawDb.execute(
          'CREATE TABLE secrets (id TEXT PRIMARY KEY, value TEXT);',
        );
        rawDb.execute(
          "INSERT INTO secrets VALUES ('1', 'super-secret-vault-data');",
        );
        rawDb.close();

        // 2. Reopen with the exact same key
        final reopenDb = sqlite3.open(dbFile.path);
        EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(reopenDb, key);
        final rows = reopenDb.select(
          "SELECT value FROM secrets WHERE id = '1';",
        );
        expect(rows.length, equals(1));
        expect(rows.first['value'], equals('super-secret-vault-data'));
        reopenDb.close();
      },
    );

    test(
      'opening an encrypted database with an incorrect key fails closed',
      () async {
        final dbFile = File(p.join(tempDir.path, 'wrong_key_test.db'));
        final correctKey = await keyManager.getOrCreateKey(userA);
        final incorrectKey = await keyManager.getOrCreateKey(userB);

        // Create with correctKey
        final rawDb = sqlite3.open(dbFile.path);
        EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(rawDb, correctKey);
        rawDb.execute('CREATE TABLE data (val TEXT);');
        rawDb.execute("INSERT INTO data VALUES ('confidential');");
        rawDb.close();

        // Reopen with incorrectKey - must fail closed
        final badDb = sqlite3.open(dbFile.path);
        expect(
          () => EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(
            badDb,
            incorrectKey,
          ),
          throwsA(isA<DatabaseSecurityException>()),
        );
        badDb.close();
      },
    );

    test('unencrypted standard SQLite connection cannot read encrypted database file', () async {
      final dbFile = File(p.join(tempDir.path, 'unencrypted_read_test.db'));
      final key = await keyManager.getOrCreateKey(userA);

      // Create encrypted database
      final rawDb = sqlite3.open(dbFile.path);
      EncryptedDatabaseFactory.applyAndVerifyEncryptionKey(rawDb, key);
      rawDb.execute('CREATE TABLE users (name TEXT);');
      rawDb.execute("INSERT INTO users VALUES ('alice');");
      rawDb.close();

      // Open without key (standard plaintext SQLite attempt)
      final plainDb = sqlite3.open(dbFile.path);
      expect(
        () => plainDb.select('SELECT count(*) FROM sqlite_master;'),
        throwsA(
          isA<SqliteException>().having(
            (e) => e.message,
            'message',
            contains('file is not a database'),
          ),
        ),
      );
      plainDb.close();
    });

    test('sanitizes user paths and isolates database files per user', () async {
      final fileA = await EncryptedDatabaseFactory.getDatabaseFileForUser(
        userId: userA,
        keyManager: keyManager,
        getDirectory: () async => tempDir,
      );

      final fileB = await EncryptedDatabaseFactory.getDatabaseFileForUser(
        userId: userB,
        keyManager: keyManager,
        getDirectory: () async => tempDir,
      );

      expect(fileA.path, isNot(equals(fileB.path)));
      expect(p.basename(fileA.path), startsWith('app_user_'));
      expect(p.basename(fileA.path), endsWith('.db'));
      expect(p.basename(fileA.path).contains('user_alice'), isFalse);
    });
  });

  group('AppDatabase Drift Integration', () {
    test(
      'opens Drift AppDatabase with encrypted executor in background',
      () async {
        final dbFile = File(p.join(tempDir.path, 'drift_user.db'));
        final key = await keyManager.getOrCreateKey(userA);

        final executor = EncryptedDatabaseFactory.createEncryptedExecutor(
          file: dbFile,
          encryptionKey: key,
          inBackground: true,
        );

        final appDb = AppDatabase.forTesting(executor);

        // Verify basic schema version query via Drift
        expect(appDb.schemaVersion, equals(1));
        final customSelect = await appDb
            .customSelect('SELECT 42 AS answer;')
            .getSingle();
        expect(customSelect.read<int>('answer'), equals(42));

        await appDb.close();

        // Verify the resulting file on disk is encrypted
        final plainDb = sqlite3.open(dbFile.path);
        expect(
          () => plainDb.select('SELECT count(*) FROM sqlite_master;'),
          throwsA(isA<SqliteException>()),
        );
        plainDb.close();
      },
    );

    test('Riverpod appDatabaseProvider creates and disposes database scoped to user', () async {
      final fakeKeyManager = FakeDatabaseKeyManager();

      final container = ProviderContainer(
        overrides: [
          databaseKeyManagerProvider.overrideWithValue(fakeKeyManager),
          requiredUserScopeProvider.overrideWithValue(
            const UserScope('riverpod-test-user-id'),
          ),
        ],
      );

      final appDb = container.read(appDatabaseProvider);
      expect(appDb, isA<AppDatabase>());
      expect(appDb.schemaVersion, equals(1));

      // Container disposal closes the database
      container.dispose();
    });
  });
}
