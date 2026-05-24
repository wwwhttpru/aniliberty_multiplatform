import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/episode.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/title_release.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/repository/video_player_repository.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state/title_episode_state.dart';
import 'package:collection/collection.dart';
import 'package:yx_state/yx_state.dart';

/// State manager for title episode loading and selection.
///
/// Manages the state of loading a title release by episode ID and selecting
/// the specific episode from the loaded release. Handles loading states,
/// success, and error cases.
class TitleEpisodeSM extends StateManager<TitleEpisodeState> {
  /// Episode identifier to load
  final String _episodeId;

  /// Repository for fetching title release data
  final IVideoPlayerRepository _repository;

  TitleEpisodeSM({
    required this._episodeId,
    required this._repository,
  }) : super(const TitleEpisodeState.idle());

  /// Loads the title release and selects the episode.
  ///
  /// Fetches the title release data from the repository using the episode ID,
  /// finds the specific episode in the release, and updates the state accordingly.
  /// Handles loading, success, and error states.
  void read() {
    handle(
      (emit) async {
        emit(const TitleEpisodeState.progress());
        try {
          final release = await _repository.readTitleReleaseByIdFromNetwork(
            _episodeId,
          );
          final episode = _getEpisodeById(release, _episodeId);

          emit(
            TitleEpisodeState.success(
              titleRelease: release,
              selectedEpisode: episode,
            ),
          );
        } on Object catch (error, sk) {
          emit(const TitleEpisodeState.error());
          addError(error, sk);
        }
      },
      identifier: 'read',
    );
  }

  /// Finds an episode by its ID in the title release.
  ///
  /// Searches through the episodes list to find the episode with the matching UUID.
  ///
  /// [release] - The title release containing episodes
  /// [episodeId] - The UUID of the episode to find
  ///
  /// Returns the found [Episode].
  ///
  /// Throws an [Exception] if the episode is not found.
  Episode _getEpisodeById(TitleRelease release, String episodeId) {
    final episode = release.episodes.firstWhereOrNull(
      (episode) => episode.uuid == episodeId,
    );

    if (episode == null) {
      throw Exception('Episode not found');
    }

    return episode;
  }
}
