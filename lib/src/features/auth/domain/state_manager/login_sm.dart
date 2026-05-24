import 'package:aniliberty_multiplatform/src/features/auth/domain/repository/auth_repository.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/state/login_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template login_sm}
/// State manager for login process
/// {@endtemplate}
class LoginSM extends StateManager<LoginState> {
  final IAuthRepository _repository;

  /// {@macro login_sm}
  LoginSM({
    required this._repository,
  }) : super(const LoginState.idle());

  /// Perform login with credentials
  ///
  /// [login] - User login
  /// [password] - User password
  void login({
    required String login,
    required String password,
  }) {
    handle(
      (emit) async {
        emit(const LoginState.progress());

        try {
          // maybe throw exception if user is already authenticated
          final isAuthenticated = await _repository.readIsAuthenticated();
          if (isAuthenticated) {
            emit(const LoginState.success());
            return;
          }

          await _repository.login(
            login: login,
            password: password,
          );

          emit(const LoginState.success());
        } on Object catch (error, stackTrace) {
          emit(const LoginState.error());
          addError(error, stackTrace);
        } finally {
          emit(const LoginState.idle());
        }
      },
      identifier: 'login',
    );
  }
}
