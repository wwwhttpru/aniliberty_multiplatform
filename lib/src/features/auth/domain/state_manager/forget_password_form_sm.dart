import 'package:aniliberty_multiplatform/src/features/auth/domain/state/forget_password_form_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template forget_password_form_sm}
/// State manager for the forget password form
/// {@endtemplate}
class ForgetPasswordFormSM extends StateManager<ForgetPasswordFormState> {
  /// {@macro forget_password_form_sm}
  ForgetPasswordFormSM() : super(initialState);

  /// Initial state for the forget password form
  static const initialState = ForgetPasswordFormState.invalid(email: '');

  /// Set email
  void setEmail(String email) {
    handle(
      (emit) async {
        final newState = _validateForm(email)
            ? ForgetPasswordFormState.valid(email: email)
            : ForgetPasswordFormState.invalid(email: email);

        emit(newState);
      },
      identifier: 'setEmail',
    );
  }

  bool _validateForm(String email) {
    // Basic email validation
    return email.isNotEmpty && email.contains('@') && email.contains('.');
  }
}
