import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_form_state.freezed.dart';

/// {@template forget_password_form_state}
/// State for the forget password form
/// {@endtemplate}
@freezed
sealed class ForgetPasswordFormState with _$ForgetPasswordFormState {
  /// Returns true if the form is valid
  bool get isValid => maybeMap(orElse: () => false, valid: (_) => true);

  /// Returns true if the form is invalid
  bool get isInvalid => maybeMap(orElse: () => false, invalid: (_) => true);

  /// Valid form
  const factory ForgetPasswordFormState.valid({
    required String email,
  }) = ValidForgetPasswordFormState;

  /// Invalid form
  const factory ForgetPasswordFormState.invalid({
    required String email,
  }) = InvalidForgetPasswordFormState;

  /// {@macro forget_password_form_state}
  const ForgetPasswordFormState._();
}
