import 'package:aniliberty_multiplatform/src/features/auth/domain/state/login_form_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template login_form_sm}
/// State manager for the login form
/// {@endtemplate}
class LoginFormSM extends StateManager<LoginFormState> {
  /// {@macro login_form_sm}
  LoginFormSM() : super(initialState);

  /// Initial state for the login form
  static const initialState = LoginFormState.invalid(login: '', password: '');

  /// Set login
  void setLogin(String login) {
    handle(
      (emit) async {
        final currentState = state;
        final password = currentState.password;

        final newState = _validateForm(login, password)
            ? LoginFormState.valid(login: login, password: password)
            : LoginFormState.invalid(login: login, password: password);

        emit(newState);
      },
      identifier: 'setLogin',
    );
  }

  /// Set password
  void setPassword(String password) {
    handle(
      (emit) async {
        final currentState = state;
        final login = currentState.login;

        final newState = _validateForm(login, password)
            ? LoginFormState.valid(login: login, password: password)
            : LoginFormState.invalid(login: login, password: password);

        emit(newState);
      },
      identifier: 'setPassword',
    );
  }

  bool _validateForm(String login, String password) {
    return login.isNotEmpty && password.isNotEmpty;
  }
}
