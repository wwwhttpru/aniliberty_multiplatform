import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_out_state.freezed.dart';

/// Log out state
@freezed
sealed class LogOutState with _$LogOutState {
  const LogOutState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (logging out)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (logged out successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (logout failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Idle state
  const factory LogOutState.idle() = IdleLogOutState;

  /// Progress state (logging out)
  const factory LogOutState.progress() = ProgressLogOutState;

  /// Success state (logged out successfully)
  const factory LogOutState.success() = SuccessLogOutState;

  /// Error state
  const factory LogOutState.error() = ErrorLogOutState;
}
