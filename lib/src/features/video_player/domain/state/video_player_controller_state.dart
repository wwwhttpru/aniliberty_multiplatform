import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

part 'video_player_controller_state.freezed.dart';

/// State representing the video player controller lifecycle.
///
/// Tracks the initialization, loading, success, error, and empty states
/// of the video player controller. Provides convenient getters to check
/// the current state and access the controller when available.
@freezed
sealed class VideoPlayerControllerState with _$VideoPlayerControllerState {
  /// Returns true if the controller is being initialized
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the controller is initialized and ready
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if an error occurred during controller initialization
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Returns true if the controller is in empty state (no video loaded)
  bool get isEmpty => maybeMap(orElse: () => false, empty: (_) => true);

  /// Returns the video player controller if available, null otherwise
  VideoPlayerController? get maybeController =>
      mapOrNull<VideoPlayerController?>(
        success: (value) => value.controller,
      );

  /// Progress state - controller is being initialized
  const factory VideoPlayerControllerState.progress() =
      _ProgressVideoPlayerControllerState;

  /// Success state - controller is initialized and ready to play video
  const factory VideoPlayerControllerState.success({
    /// The initialized video player controller
    required VideoPlayerController controller,
  }) = _SuccessPlayerControllerState;

  /// Error state - failed to initialize the controller
  const factory VideoPlayerControllerState.error() =
      _ErrorVideoPlayerControllerState;

  /// Empty state - no video is loaded (placeholder state)
  const factory VideoPlayerControllerState.empty() =
      _EmptyVideoPlayerControllerState;

  const VideoPlayerControllerState._();
}
