import 'package:aniliberty_multiplatform/src/features/video_player/domain/state/video_player_controller_state.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';
import 'package:yx_state/yx_state.dart';

/// Manager for video player controller lifecycle.
///
/// Handles initialization, disposal, and state management of video player controllers.
/// Supports HLS streaming and manages transitions between different controller states
/// (progress, success, error, empty).
class VideoPlayerControllerManager
    extends StateManager<VideoPlayerControllerState> {
  VideoPlayerControllerManager()
    : super(const VideoPlayerControllerState.progress());

  /// Sets the HLS stream URI and initializes a new video player controller.
  ///
  /// Disposes the previous controller (if any) and creates a new controller
  /// for the specified HLS stream URI. The controller is configured for HLS
  /// streaming with web-specific options disabled.
  ///
  /// [uri] - The HLS stream URI to play
  ///
  /// Updates state to progress during initialization, success when ready,
  /// or error if initialization fails.
  void setHlsUri(Uri uri, {Duration? position}) {
    handle(
      (emit) async {
        final prev = state.maybeController;
        emit(const VideoPlayerControllerState.progress());

        try {
          await prev?.dispose();

          final next = VideoPlayerController.networkUrl(
            uri,
            formatHint: VideoFormat.hls,
            videoPlayerOptions: VideoPlayerOptions(
              webOptions: const VideoPlayerWebOptions(
                allowContextMenu: false,
                allowRemotePlayback: false,
              ),
            ),
          );
          await next.initialize();

          // Seek to the specified position if provided
          if (position != null) {
            await next.seekTo(position);
          }
          emit(VideoPlayerControllerState.success(controller: next));
        } on Object {
          emit(const VideoPlayerControllerState.error());
          rethrow;
        }
      },
      identifier: 'setUri',
    );
  }

  /// Sets the player to empty state (no video loaded).
  ///
  /// Disposes the current controller and sets the state to empty,
  /// typically used when no episode is selected or no stream is available.
  void setEmpty() {
    handle(
      (emit) async {
        final prev = state.maybeController;
        emit(const VideoPlayerControllerState.progress());

        try {
          await prev?.dispose();
        } on Object catch (error, sk) {
          addError(error, sk);
        } finally {
          emit(const VideoPlayerControllerState.empty());
        }
      },
      identifier: 'setEmpty',
    );
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    await state.maybeController?.dispose();
    return super.close();
  }
}
