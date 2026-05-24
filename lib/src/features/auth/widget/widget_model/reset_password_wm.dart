import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template reset_password_wm}
/// Widget model for the reset password screen
/// {@endtemplate}
abstract interface class IResetPasswordWM {
  /// Get token
  String get token;

  /// Get password
  String get password;

  /// Get password confirmation
  String get passwordConfirmation;

  /// Close reset password screen
  void close();

  /// Set token
  void setToken(String token);

  /// Set password
  void setPassword(String password);

  /// Set password confirmation
  void setPasswordConfirmation(String passwordConfirmation);

  /// Reset password
  void resetPassword();
}

/// {@macro reset_password_wm}
@immutable
class ResetPasswordWM implements IResetPasswordWM {
  /// {@macro reset_password_form_sm}
  final ResetPasswordFormSM _resetPasswordFormSM;

  /// {@macro reset_password_sm}
  final ResetPasswordSM _resetPasswordSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  @override
  String get token => _resetPasswordFormSM.state.token;

  @override
  String get password => _resetPasswordFormSM.state.password;

  @override
  String get passwordConfirmation =>
      _resetPasswordFormSM.state.passwordConfirmation;

  /// {@macro reset_password_wm}
  const ResetPasswordWM({
    required this._resetPasswordFormSM,
    required this._resetPasswordSM,
    required this._navigationInteractor,
  });

  @override
  void close() => _navigationInteractor.closeResetPassword();

  @override
  void setToken(String token) {
    final value = token.trim();
    final current = _resetPasswordFormSM.state.token;
    if (value == current) {
      return;
    }

    _resetPasswordFormSM.setToken(value);
  }

  @override
  void setPassword(String password) {
    final value = password.trim();
    final current = _resetPasswordFormSM.state.password;
    if (value == current) {
      return;
    }

    _resetPasswordFormSM.setPassword(value);
  }

  @override
  void setPasswordConfirmation(String passwordConfirmation) {
    final value = passwordConfirmation.trim();
    final current = _resetPasswordFormSM.state.passwordConfirmation;
    if (value == current) {
      return;
    }

    _resetPasswordFormSM.setPasswordConfirmation(value);
  }

  @override
  void resetPassword() {
    final formState = _resetPasswordFormSM.state;
    final resetPasswordState = _resetPasswordSM.state;

    // Check if form is valid and reset password state is idle
    if (!formState.isValid || !resetPasswordState.isIdle) {
      return;
    }

    _resetPasswordSM.resetPassword(
      token: formState.token,
      password: formState.password,
      passwordConfirmation: formState.passwordConfirmation,
    );
  }
}
