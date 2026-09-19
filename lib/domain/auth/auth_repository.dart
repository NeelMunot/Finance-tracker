import 'auth_user.dart';

abstract interface class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signInWithGoogle();

  Future<void> signOut();
}
