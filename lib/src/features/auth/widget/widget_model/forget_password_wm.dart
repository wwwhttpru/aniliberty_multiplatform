import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template forget_password_wm}
/// Widget model for the forget password screen
/// {@endtemplate}
abstract interface class IForgetPasswordWM {
  /// Get email
  String get email;

  /// Close forget password screen
  void close();

  /// Set email
  void setEmail(String email);

  /// Request password reset
  void requestPasswordReset();

  /// Open reset password screen
  void openResetPassword();
}

/// {@macro forget_password_wm}
@immutable
class ForgetPasswordWM implements IForgetPasswordWM {
  /// {@macro forget_password_form_sm}
  final ForgetPasswordFormSM _forgetPasswordFormSM;

  /// {@macro forget_password_sm}
  final ForgetPasswordSM _forgetPasswordSM;

  /// {@macro auth_navigation_interactor}
  final IAuthNavigationInteractor _navigationInteractor;

  @override
  String get email => _forgetPasswordFormSM.state.email;

  /// {@macro forget_password_wm}
  const ForgetPasswordWM({
    required this._forgetPasswordFormSM,
    required this._forgetPasswordSM,
    required this._navigationInteractor,
  });

  @override
  void close() => _navigationInteractor.closeForgetPassword();

  @override
  void setEmail(String email) {
    final value = email.trim();
    final current = _forgetPasswordFormSM.state.email;
    if (value == current) {
      return;
    }

    _forgetPasswordFormSM.setEmail(value);
  }

  @override
  void requestPasswordReset() {
    final formState = _forgetPasswordFormSM.state;
    final forgetPasswordState = _forgetPasswordSM.state;

    // Check if form is valid and forget password state is idle
    if (!formState.isValid || !forgetPasswordState.isIdle) {
      return;
    }

    _forgetPasswordSM.forgetPassword(
      email: formState.email,
    );
  }

  @override
  void openResetPassword() => _navigationInteractor.openResetPassword();
}
