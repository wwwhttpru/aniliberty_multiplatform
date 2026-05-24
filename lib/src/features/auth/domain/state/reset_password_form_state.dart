import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_form_state.freezed.dart';

/// {@template reset_password_form_state}
/// State for the reset password form
/// {@endtemplate}
@freezed
sealed class ResetPasswordFormState with _$ResetPasswordFormState {
  /// Returns true if the form is valid
  bool get isValid => maybeMap(orElse: () => false, valid: (_) => true);

  /// Returns true if the form is invalid
  bool get isInvalid => maybeMap(orElse: () => false, invalid: (_) => true);

  /// Valid form
  const factory ResetPasswordFormState.valid({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) = ValidResetPasswordFormState;

  /// Invalid form
  const factory ResetPasswordFormState.invalid({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) = InvalidResetPasswordFormState;

  /// {@macro reset_password_form_state}
  const ResetPasswordFormState._();
}
