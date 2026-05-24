import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

/// {@template reset_password_state}
/// State for reset password process
/// {@endtemplate}
@freezed
sealed class ResetPasswordState with _$ResetPasswordState {
  const ResetPasswordState._();

  /// Returns true if the state is idle
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Waiting for user actions
  const factory ResetPasswordState.idle() = IdleResetPasswordState;

  /// Loading data
  const factory ResetPasswordState.progress() = ProgressResetPasswordState;

  /// Password reset successfully
  const factory ResetPasswordState.success() = SuccessResetPasswordState;

  /// An error occurred
  const factory ResetPasswordState.error() = ErrorResetPasswordState;
}
