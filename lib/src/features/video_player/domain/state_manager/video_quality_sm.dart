import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/video_quality.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/repository/video_player_repository.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state/video_quality_state.dart';
import 'package:yx_state/yx_state.dart';

/// State manager for video quality selection.
///
/// Manages the state of selecting a video quality for playback. Handles
/// quality selection and provides methods to change the selected quality.
class VideoQualitySM extends StateManager<VideoQualityState> {
  /// Repository for fetching video quality data
  final IVideoPlayerRepository _repository;

  VideoQualitySM({
    required this._repository,
  }) : super(const VideoQualityState.idle());

  /// Reads the selected video quality from the repository.
  ///
  /// Fetches the saved video quality preference from the repository and
  /// updates the state accordingly. Handles loading, success, and error states.
  void read() {
    handle(
      (emit) async {
        emit(const VideoQualityState.progress());
        try {
          final quality = await _repository.readVideoQuality();
          emit(VideoQualityState.success(quality: quality));
        } on Object catch (error, stackTrace) {
          emit(const VideoQualityState.error());
          addError(error, stackTrace);
        }
      },
      identifier: 'read',
    );
  }

  /// Selects a video quality.
  ///
  /// Updates the state to reflect the selected quality.
  ///
  /// [quality] - The video quality to select
  void selectQuality(VideoQuality quality) {
    handle(
      (emit) async {
        emit(const VideoQualityState.progress());
        try {
          emit(VideoQualityState.success(quality: quality));
        } on Object catch (error, stackTrace) {
          emit(const VideoQualityState.error());
          addError(error, stackTrace);
        }
      },
      identifier: 'selectQuality',
    );
  }
}
