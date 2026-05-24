import 'package:aniliberty_multiplatform/src/datasource_v2/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

/// Profile state
@freezed
sealed class ProfileState with _$ProfileState {
  const ProfileState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (data loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns the profile if available, null otherwise
  UserProfileModel? get profileOrNull => maybeMap(
    orElse: () => null,
    success: (value) => value.profile,
  );

  /// Idle state
  const factory ProfileState.idle() = IdleProfileState;

  /// Progress state (loading)
  const factory ProfileState.progress() = ProgressProfileState;

  /// Success state with profile data
  const factory ProfileState.success({
    required UserProfileModel profile,
  }) = SuccessProfileState;

  /// Error state
  const factory ProfileState.error() = ErrorProfileState;
}
