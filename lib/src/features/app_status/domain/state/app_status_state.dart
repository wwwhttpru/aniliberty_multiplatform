import 'package:aniliberty_multiplatform/src/datasource_v2/app_status/app_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status_state.freezed.dart';

/// App status state
@freezed
sealed class AppStatusState with _$AppStatusState {
  const AppStatusState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns the app status if available, null otherwise
  AppStatusModel? get appStatusOrNull => maybeMap(
    orElse: () => null,
    success: (value) => value.appStatus,
  );

  /// Idle state
  const factory AppStatusState.idle() = IdleAppStatusState;

  /// Progress state (loading)
  const factory AppStatusState.progress() = ProgressAppStatusState;

  /// Success state with app status data
  const factory AppStatusState.success({
    required AppStatusModel appStatus,
  }) = SuccessAppStatusState;

  /// Error state
  const factory AppStatusState.error() = ErrorAppStatusState;
}
