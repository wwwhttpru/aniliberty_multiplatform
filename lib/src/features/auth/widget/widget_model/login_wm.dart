import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template login_wm}
/// Widget model for the login screen
/// {@endtemplate}
abstract interface class ILoginWM {
  /// Get login
  String get login;

  /// Get password
  String get password;

  /// Close login screen
  void close();

  /// Set login
  void setLogin(String login);

  /// Set password
  void setPassword(String password);

  /// Sign in
  void signIn();

  /// Forgot password
  void forgotPassword();

  /// Sign up
  void signUp();
}

/// {@macro login_wm}
@immutable
class LoginWM implements ILoginWM {
  /// {@macro login_form_sm}
  final LoginFormSM _loginFormSM;

  /// {@macro login_sm}
  final LoginSM _loginSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  /// App url config
  final AppUrlConfig _appUrlConfig;

  /// Url launcher for opening urls
  final UrlLauncher _urlLauncher;

  @override
  String get login => _loginFormSM.state.login;

  @override
  String get password => _loginFormSM.state.password;

  /// {@macro login_wm}
  const LoginWM({
    required this._loginFormSM,
    required this._loginSM,
    required this._navigationInteractor,
    required this._appUrlConfig,
    required this._urlLauncher,
  });

  @override
  void close() => _navigationInteractor.closeLogin();

  @override
  void setLogin(String login) {
    final value = login.trim();
    final current = _loginFormSM.state.login;
    if (value == current) {
      return;
    }

    _loginFormSM.setLogin(value);
  }

  @override
  void setPassword(String password) {
    final value = password.trim();
    final current = _loginFormSM.state.password;
    if (value == current) {
      return;
    }

    _loginFormSM.setPassword(value);
  }

  @override
  void signIn() {
    final formState = _loginFormSM.state;
    final loginState = _loginSM.state;

    // Check if form is valid and login state is idle
    if (!formState.isValid || !loginState.isIdle) {
      return;
    }

    _loginSM.login(
      login: formState.login,
      password: formState.password,
    );
  }

  @override
  void forgotPassword() => _navigationInteractor.openForgetPassword();

  @override
  void signUp() {
    final url = Uri.parse(_appUrlConfig.signUp);
    if (!_urlLauncher.state.isIdle) {
      return;
    }

    return _urlLauncher.open(url);
  }
}
