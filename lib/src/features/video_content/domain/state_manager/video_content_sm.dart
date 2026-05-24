import 'package:aniliberty_multiplatform/src/features/video_content/domain/repository/video_content_repository.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/state/video_content_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template video_content_sm}
/// State manager for video content feature.
///
/// Manages the video content state and handles video content loading operations.
/// {@endtemplate}
class VideoContentSM extends StateManager<VideoContentState> {
  /// {@macro i_video_content_repository}
  final IVideoContentRepository _repository;

  /// {@macro video_content_sm}
  ///
  /// Creates a new instance of [VideoContentSM].
  ///
  /// [_repository] - The repository for video content operations
  VideoContentSM({required this._repository})
    : super(const VideoContentState.idle());

  /// Reads video content items.
  ///
  /// Loads video content items up to the specified limit and updates state accordingly:
  /// - Sets state to [VideoContentState.progress] while loading
  /// - Sets state to [VideoContentState.success] with results on success
  /// - Sets state to [VideoContentState.error] on failure
  ///
  /// [limit] - The maximum number of video content items to load
  void read(int limit) => handle(
    (emit) async {
      emit(const VideoContentState.progress());
      try {
        final videoContents = await _repository.readVideoContentsFromNetwork(
          limit: limit,
        );
        emit(VideoContentState.success(mediaVideoContents: videoContents));
      } on Object catch (error, sk) {
        emit(const VideoContentState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );
}
