import 'package:aniliberty_multiplatform/src/features/auth/domain/state/reset_password_form_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template reset_password_form_sm}
/// State manager for the reset password form
/// {@endtemplate}
class ResetPasswordFormSM extends StateManager<ResetPasswordFormState> {
  /// {@macro reset_password_form_sm}
  ResetPasswordFormSM() : super(initialState);

  /// Initial state for the reset password form
  static const initialState = ResetPasswordFormState.invalid(
    token: '',
    password: '',
    passwordConfirmation: '',
  );

  /// Set token
  void setToken(String token) {
    handle(
      (emit) async {
        final currentState = state;
        final password = currentState.password;
        final passwordConfirmation = currentState.passwordConfirmation;

        final newState = _validateForm(token, password, passwordConfirmation)
            ? ResetPasswordFormState.valid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              )
            : ResetPasswordFormState.invalid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              );

        emit(newState);
      },
      identifier: 'setToken',
    );
  }

  /// Set password
  void setPassword(String password) {
    handle(
      (emit) async {
        final currentState = state;
        final token = currentState.token;
        final passwordConfirmation = currentState.passwordConfirmation;

        final newState = _validateForm(token, password, passwordConfirmation)
            ? ResetPasswordFormState.valid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              )
            : ResetPasswordFormState.invalid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              );

        emit(newState);
      },
      identifier: 'setPassword',
    );
  }

  /// Set password confirmation
  void setPasswordConfirmation(String passwordConfirmation) {
    handle(
      (emit) async {
        final currentState = state;
        final token = currentState.token;
        final password = currentState.password;

        final newState = _validateForm(token, password, passwordConfirmation)
            ? ResetPasswordFormState.valid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              )
            : ResetPasswordFormState.invalid(
                token: token,
                password: password,
                passwordConfirmation: passwordConfirmation,
              );

        emit(newState);
      },
      identifier: 'setPasswordConfirmation',
    );
  }

  bool _validateForm(
    String token,
    String password,
    String passwordConfirmation,
  ) {
    return token.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirmation.isNotEmpty &&
        password == passwordConfirmation;
  }
}
