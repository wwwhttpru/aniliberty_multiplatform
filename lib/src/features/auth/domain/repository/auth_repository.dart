/// {@template i_auth_repository}
/// Interface for authentication repository
/// {@endtemplate}
abstract interface class IAuthRepository {
  /// Stream of authentication state changes
  Stream<bool> get isAuthenticatedStream;

  /// Read whether the user is authenticated
  ///
  /// Returns `true` if the user is authenticated, `false` otherwise
  Future<bool> readIsAuthenticated();

  /// Authenticate user by login and password
  ///
  /// [login] - User login
  /// [password] - User password
  ///
  /// Returns [void] on success
  /// Throws exception on error (401, 422, etc.)
  Future<void> login({
    required String login,
    required String password,
  });

  /// Logout user
  ///
  /// Throws exception on error (401, etc.)
  Future<void> logout();

  /// Request password reset
  ///
  /// [email] - User email
  ///
  /// Returns [void] on success
  /// Throws exception on error (422, etc.)
  Future<void> forgetPassword({
    required String email,
  });

  /// Reset password with token
  ///
  /// [token] - Token from email
  /// [password] - New password
  /// [passwordConfirmation] - Password confirmation
  ///
  /// Returns [void] on success
  /// Throws exception on error (404, 422, etc.)
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  });
}
