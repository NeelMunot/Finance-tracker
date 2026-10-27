import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Contract for managing user-scoped local database encryption keys.
///
/// Implementations must store keys securely, ensure filesystem safety for
/// user-derived paths, and never expose key material in logs or exceptions.
abstract interface class DatabaseKeyManager {
  /// Retrieves the existing 256-bit encryption key or generates and securely stores
  /// a new one for the given [userId].
  ///
  /// Returns a 64-character hexadecimal string representing 256 bits of cryptographically
  /// secure entropy.
  Future<String> getOrCreateKey(String userId);

  /// Explicitly deletes the encryption key for [userId].
  ///
  /// This must only be invoked during explicit, user-initiated account or local data
  /// wiping, never during normal sign-out.
  Future<void> deleteKey(String userId);

  /// Derives a stable, filesystem-safe hash from [userId] to ensure raw identifiers
  /// are not exposed in filenames or directory structures.
  String sanitizeUserId(String userId);
}

/// Thrown when encryption key retrieval, generation, or storage operations fail.
///
/// Contains no sensitive key material in its message or stack trace.
class DatabaseKeyException implements Exception {
  const DatabaseKeyException(this.message);

  final String message;

  @override
  String toString() => 'DatabaseKeyException: $message';
}

/// Helper extension providing standard SHA-256 user ID sanitization.
extension UserSanitizer on String {
  String toSanitizedUserHash() {
    return sha256.convert(utf8.encode(this)).toString();
  }
}
