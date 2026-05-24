import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

/// {@template i_auth_remote_db}
/// Interface for remote data source that provides authentication data
/// {@endtemplate}
abstract interface class IAuthRemoteDB {
  /// Authenticate user by login and password
  ///
  /// Creates user session and issues authorization token
  /// for use in cookies or Bearer Token
  ///
  /// [login] - User login
  /// [password] - User password
  ///
  /// Throws [DioException] with status 401 if login/password is incorrect
  /// Throws [DioException] with status 422 if login/password is not provided
  Future<AuthLoginResponseModel> login({
    required String login,
    required String password,
  });

  /// Logout user
  ///
  /// Throws [DioException] with status 401 if user is not authenticated
  Future<AuthLogoutResponseModel> logout();

  /// Request password reset
  ///
  /// Sends password reset email to the user
  ///
  /// [email] - User email
  Future<void> forgetPassword({
    required String email,
  });

  /// Reset password with token
  ///
  /// Resets user password using token from email
  ///
  /// [token] - Token from email
  /// [password] - New password
  /// [passwordConfirmation] - Password confirmation
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  });
}

/// {@macro i_auth_remote_db}
///
/// For more API details: <https://anilibria.top/api/docs/v1#/>
@immutable
final class AuthRemoteDB implements IAuthRemoteDB {
  final AppNetwork _appNetwork;

  /// {@macro i_auth_remote_db}
  const AuthRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<AuthLoginResponseModel> login({
    required String login,
    required String password,
  }) async {
    assert(login.isNotEmpty, 'Login must not be empty');
    assert(password.isNotEmpty, 'Password must not be empty');

    final requestData = <String, Object?>{
      'login': login,
      'password': password,
    };

    final response = await _appNetwork.coreV2.post<Map<String, Object?>>(
      '/accounts/users/auth/login',
      data: requestData,
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AuthLoginResponseModel.fromJson(data);
  }

  @override
  Future<AuthLogoutResponseModel> logout() async {
    final response = await _appNetwork.coreV2.post<Map<String, Object?>>(
      '/accounts/users/auth/logout',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AuthLogoutResponseModel.fromJson(data);
  }

  @override
  Future<void> forgetPassword({
    required String email,
  }) async {
    assert(email.isNotEmpty, 'Email must not be empty');

    final requestData = <String, Object?>{
      'email': email,
    };

    await _appNetwork.coreV2.post<Map<String, Object?>>(
      '/accounts/users/auth/password/forget',
      data: requestData,
    );
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    assert(token.isNotEmpty, 'Token must not be empty');
    assert(password.isNotEmpty, 'Password must not be empty');
    assert(
      passwordConfirmation.isNotEmpty,
      'Password confirmation must not be empty',
    );

    final requestData = <String, Object?>{
      'token': token,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    await _appNetwork.coreV2.post<Map<String, Object?>>(
      '/accounts/users/auth/password/reset',
      data: requestData,
    );
  }
}
