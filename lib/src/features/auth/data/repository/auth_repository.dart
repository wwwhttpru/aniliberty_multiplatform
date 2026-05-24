import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/data/datasource/auth_local_db.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/datasource/auth_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/model/auth_token.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template auth_repository}
/// Repository for authentication operations
/// {@endtemplate}
@immutable
final class AuthRepository implements IAuthRepository {
  /// {@macro i_auth_remote_db}
  final IAuthRemoteDB _remoteDB;

  /// {@macro i_auth_local_db}
  final IAuthLocalDB _localDB;

  @override
  Stream<bool> get isAuthenticatedStream => _localDB.tokenStream.map(
    (token) => token != null,
  );

  /// {@macro auth_repository}
  const AuthRepository({
    required this._remoteDB,
    required this._localDB,
  });

  @override
  Future<bool> readIsAuthenticated() async {
    final token = await _localDB.readToken();
    return token != null;
  }

  @override
  Future<void> login({
    required String login,
    required String password,
  }) async {
    final response = await _remoteDB.login(
      login: login,
      password: password,
    );

    final dataToken = AuthToken(token: response.token);
    await _localDB.createOrUpdateToken(dataToken);
  }

  @override
  Future<void> logout() async {
    await _remoteDB.logout();
    await _localDB.deleteToken();
  }

  @override
  Future<void> forgetPassword({
    required String email,
  }) => _remoteDB.forgetPassword(email: email);

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) => _remoteDB.resetPassword(
    token: token,
    password: password,
    passwordConfirmation: passwordConfirmation,
  );
}
