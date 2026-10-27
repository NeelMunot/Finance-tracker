import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finance_tracker/domain/security/database_key_manager.dart';
import 'package:finance_tracker/infrastructure/security/secure_storage_database_key_manager.dart';

import '../fakes/fake_database_key_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureStorageDatabaseKeyManager', () {
    late SecureStorageDatabaseKeyManager keyManager;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      keyManager = SecureStorageDatabaseKeyManager();
    });

    test('generates a cryptographically secure 256-bit (64 hex) key', () async {
      const userId = 'firebase-user-123';
      final key = await keyManager.getOrCreateKey(userId);

      expect(key, hasLength(64));
      expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(key), isTrue);
    });

    test(
      'returns the identical key when called repeatedly for the same user',
      () async {
        const userId = 'firebase-user-abc';
        final key1 = await keyManager.getOrCreateKey(userId);
        final key2 = await keyManager.getOrCreateKey(userId);

        expect(key1, equals(key2));
      },
    );

    test('generates distinct keys for distinct users', () async {
      const userA = 'user-alice';
      const userB = 'user-bob';

      final keyA = await keyManager.getOrCreateKey(userA);
      final keyB = await keyManager.getOrCreateKey(userB);

      expect(keyA, isNot(equals(keyB)));
    });

    test('sanitizes user IDs to stable filesystem-safe SHA-256 hashes without exposing raw UID', () {
      const rawUserId = 'sensitive_uid_john_doe@example.com';
      final sanitized = keyManager.sanitizeUserId(rawUserId);

      expect(sanitized, hasLength(64));
      expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(sanitized), isTrue);
      expect(sanitized.contains('john_doe'), isFalse);
      expect(sanitized.contains('example.com'), isFalse);

      // Deterministic check
      expect(keyManager.sanitizeUserId(rawUserId), equals(sanitized));
    });

    test('throws DatabaseKeyException for empty or blank user ID', () {
      expect(
        () => keyManager.sanitizeUserId(''),
        throwsA(isA<DatabaseKeyException>()),
      );
      expect(
        () => keyManager.sanitizeUserId('   '),
        throwsA(isA<DatabaseKeyException>()),
      );
    });

    test(
      'throws DatabaseKeyException without leaking key on corrupt stored key',
      () async {
        const userId = 'corrupt-key-user';
        final sanitized = keyManager.sanitizeUserId(userId);
        // Inject corrupt key (not 64 hex characters)
        FlutterSecureStorage.setMockInitialValues({
          'db_key_$sanitized': 'corrupted_short_key_123',
        });

        expect(
          () => keyManager.getOrCreateKey(userId),
          throwsA(
            isA<DatabaseKeyException>().having(
              (e) => e.message,
              'message',
              contains('corrupted or has an invalid format'),
            ),
          ),
        );
      },
    );

    test(
      'deleteKey removes the stored key so next retrieval generates fresh key',
      () async {
        const userId = 'user-to-delete';
        final key1 = await keyManager.getOrCreateKey(userId);

        await keyManager.deleteKey(userId);

        final key2 = await keyManager.getOrCreateKey(userId);
        expect(key2, isNot(equals(key1)));
        expect(key2, hasLength(64));
      },
    );

    test('never includes encryption key in exception toString', () {
      const exception = DatabaseKeyException(
        'Failed to access secure key storage.',
      );
      expect(exception.toString(), isNot(contains('key_')));
      expect(
        exception.toString(),
        equals('DatabaseKeyException: Failed to access secure key storage.'),
      );
    });
  });

  group('FakeDatabaseKeyManager', () {
    late FakeDatabaseKeyManager fakeManager;

    setUp(() {
      fakeManager = FakeDatabaseKeyManager();
    });

    test('generates, persists, and deletes keys in memory', () async {
      const userId = 'test-fake-user';
      expect(fakeManager.hasKey(userId), isFalse);

      final key1 = await fakeManager.getOrCreateKey(userId);
      expect(key1, hasLength(64));
      expect(fakeManager.hasKey(userId), isTrue);

      final key2 = await fakeManager.getOrCreateKey(userId);
      expect(key1, equals(key2));

      await fakeManager.deleteKey(userId);
      expect(fakeManager.hasKey(userId), isFalse);
    });

    test('handles corrupt keys according to contract', () async {
      const userId = 'fake-corrupt-user';
      fakeManager.seedCorruptKey(userId, 'not-a-valid-hex-key');

      expect(
        () => fakeManager.getOrCreateKey(userId),
        throwsA(isA<DatabaseKeyException>()),
      );
    });
  });
}
