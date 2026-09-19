import 'auth_user.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.user);

  final AuthUser user;
}

class AuthError extends AuthState {
  const AuthError(this.error, [this.stackTrace]);

  final Object error;
  final StackTrace? stackTrace;
}
