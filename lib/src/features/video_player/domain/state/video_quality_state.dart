import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/video_quality.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_quality_state.freezed.dart';

/// State representing the selected video quality.
///
/// This state machine tracks the currently selected video quality for playback.
/// It provides convenient getters to check the current state and access the
/// selected quality when available.
@freezed
sealed class VideoQualityState with _$VideoQualityState {
  const VideoQualityState._();

  /// Returns true if no quality is selected (idle state)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if quality is currently being loaded
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if a quality has been successfully selected
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if an error occurred while selecting quality
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns the selected quality if available, null otherwise
  VideoQuality? get qualityOrNull => maybeMap(
    orElse: () => null,
    success: (value) => value.quality,
  );

  /// Initial state - no quality selected
  const factory VideoQualityState.idle() = _IdleVideoQualityState;

  /// Loading state - quality is being selected
  const factory VideoQualityState.progress() = _ProgressVideoQualityState;

  /// Success state - a quality has been chosen
  const factory VideoQualityState.success({
    /// The selected video quality
    required VideoQuality quality,
  }) = _SuccessVideoQualityState;

  /// Error state - failed to select quality
  const factory VideoQualityState.error() = _ErrorVideoQualityState;
}
