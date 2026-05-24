import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_state.freezed.dart';

/// {@template login_form_state}
/// State for the login form
/// {@endtemplate}
@freezed
sealed class LoginFormState with _$LoginFormState {
  /// Returns true if the form is valid
  bool get isValid => maybeMap(orElse: () => false, valid: (_) => true);

  /// Returns true if the form is invalid
  bool get isInvalid => maybeMap(orElse: () => false, invalid: (_) => true);

  /// Valid form
  const factory LoginFormState.valid({
    required String login,
    required String password,
  }) = ValidLoginFormState;

  /// Invalid form
  const factory LoginFormState.invalid({
    required String login,
    required String password,
  }) = InvalidLoginFormState;

  /// {@macro login_form_state}
  const LoginFormState._();
}
