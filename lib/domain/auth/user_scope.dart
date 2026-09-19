class UserScope {
  const UserScope(this.userId);

  final String userId;
}

class UnauthenticatedUserException implements Exception {
  const UnauthenticatedUserException();

  @override
  String toString() => 'An authenticated user is required for this operation.';
}
