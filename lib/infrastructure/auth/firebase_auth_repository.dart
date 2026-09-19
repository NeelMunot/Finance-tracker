import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/auth_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  Future<void>? _googleSignInInitialization;

  @override
  Stream<AuthUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_mapUser);
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    await (_googleSignInInitialization ??= _googleSignIn.initialize());
    final googleUser = await _googleSignIn.authenticate();
    final googleAuthentication = googleUser.authentication;
    final idToken = googleAuthentication.idToken;

    if (idToken == null) {
      throw StateError('Google Sign-In did not return an ID token.');
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final result = await _firebaseAuth.signInWithCredential(credential);
    final user = result.user;

    if (user == null) {
      throw StateError('Firebase Authentication returned no user.');
    }

    return _mapRequiredUser(user);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  AuthUser? _mapUser(User? user) {
    return user == null ? null : _mapRequiredUser(user);
  }

  AuthUser _mapRequiredUser(User user) {
    return AuthUser(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }
}
