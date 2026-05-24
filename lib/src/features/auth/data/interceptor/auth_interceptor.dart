import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/datasource/auth_local_db.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/model/auth_token.dart';
import 'package:dio/dio.dart';

/// {@template auth_interceptor}
/// Interceptor for authentication
/// {@endtemplate}
final class AuthInterceptor extends QueuedInterceptor {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_auth_local_db}
  final IAuthLocalDB _localDB;

  /// {@macro auth_interceptor}
  AuthInterceptor({
    required this._appNetwork,
    required this._localDB,
  });

  /// Initialize auth interceptor
  Future<void> init() {
    _appNetwork.coreV2.interceptors.add(this);
    return Future<void>.value();
  }

  /// Dispose auth interceptor
  Future<void> dispose() {
    _appNetwork.coreV2.interceptors.remove(this);
    return Future<void>.value();
  }

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await _localDB.readToken();
    final headers = _tokenHeader(currentToken);
    options.headers.addAll(headers);
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final currentToken = await _localDB.readToken();
    if (currentToken == null || !_shouldRefresh(response)) {
      return handler.next(response);
    }

    await _localDB.deleteToken();
    return handler.next(response);
  }

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final currentToken = await _localDB.readToken();
    if (response == null || currentToken == null || !_shouldRefresh(response)) {
      return handler.next(err);
    }

    await _localDB.deleteToken();
    return handler.next(err);
  }

  Map<String, String> _tokenHeader(AuthToken? token) {
    final value = token?.token;
    if (value == null) {
      return const <String, String>{};
    }
    return {'Authorization': 'Bearer $value'};
  }

  bool _shouldRefresh(
    Response<Object?> response,
  ) => switch (response.statusCode) {
    401 || 403 || 404 => true,
    _ => false,
  };
}
