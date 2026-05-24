import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_state.freezed.dart';

/// {@template forget_password_state}
/// State for forget password process
/// {@endtemplate}
@freezed
sealed class ForgetPasswordState with _$ForgetPasswordState {
  const ForgetPasswordState._();

  /// Returns true if the state is idle
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Waiting for user actions
  const factory ForgetPasswordState.idle() = IdleForgetPasswordState;

  /// Loading data
  const factory ForgetPasswordState.progress() = ProgressForgetPasswordState;

  /// Email sent successfully
  const factory ForgetPasswordState.success() = SuccessForgetPasswordState;

  /// An error occurred
  const factory ForgetPasswordState.error() = ErrorForgetPasswordState;
}
