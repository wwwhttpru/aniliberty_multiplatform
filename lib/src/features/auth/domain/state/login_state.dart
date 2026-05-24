import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// {@template login_state}
/// State for login process
/// {@endtemplate}
@freezed
sealed class LoginState with _$LoginState {
  const LoginState._();

  /// Returns true if the state is idle
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Waiting for user actions
  const factory LoginState.idle() = IdleLoginState;

  /// Loading data
  const factory LoginState.progress() = ProgressLoginState;

  /// Authentication successful
  const factory LoginState.success() = SuccessLoginState;

  /// An error occurred
  const factory LoginState.error() = ErrorLoginState;
}
