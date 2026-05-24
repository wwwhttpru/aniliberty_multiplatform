import 'dart:async';

import 'package:aniliberty_multiplatform/src/core/database/database.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/model/auth_token.dart';

/// {@template i_auth_local_db}
/// Interface for local data source that stores user authentication token
/// {@endtemplate}
abstract interface class IAuthLocalDB {
  /// Stream of authorization token changes
  Stream<AuthToken?> get tokenStream;

  /// Create or update authorization token in local storage
  ///
  /// [token] - Authorization token to save
  Future<void> createOrUpdateToken(AuthToken token);

  /// Read authorization token from local storage
  ///
  /// Returns the saved token, or `null` if no token is stored
  Future<AuthToken?> readToken();

  /// Delete authorization token from local storage
  Future<void> deleteToken();
}

/// {@macro i_auth_local_db}
///
/// Secure storage implementation of local storage for authentication token.
/// Uses flutter_secure_storage to persist data securely across app restarts.
final class AuthLocalDB implements IAuthLocalDB {
  /// Secure storage instance
  final IKeyValueDB<String> _keyValueDB;

  /// Controller for authorization token changes
  final _tokenController = StreamController<AuthToken?>.broadcast();

  /// Stream of authorization token changes
  @override
  Stream<AuthToken?> get tokenStream => _tokenController.stream;

  /// Authorization token cache
  AuthToken? _token;

  /// {@macro i_auth_local_db}
  AuthLocalDB({
    required this._keyValueDB,
  });

  /// Initializes the local data source and loads authentication state
  Future<void> init() async {
    AuthToken? token;
    try {
      token = await readToken();
    } finally {
      _setToken(token);
    }
  }

  /// Closes the local data source and disposes resources
  Future<void> dispose() async {
    await _tokenController.close();
    _token = null;
  }

  @override
  Future<void> createOrUpdateToken(AuthToken token) async {
    final value = token.token;
    await _keyValueDB.createOrUpdate(value);
    _setToken(token);
  }

  @override
  Future<AuthToken?> readToken() async {
    if (_token != null) {
      return _token;
    }

    final value = await _keyValueDB.read();
    if (value == null) {
      return null;
    }
    final token = AuthToken(token: value);
    return token;
  }

  @override
  Future<void> deleteToken() async {
    await _keyValueDB.delete();
    _setToken(null);
  }

  void _setToken(AuthToken? token) {
    _token = token;
    _tokenController.add(_token);
  }
}
