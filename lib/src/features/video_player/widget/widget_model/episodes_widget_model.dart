import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IEpisodesWM {
  /// Index of the currently selected episode
  int? get selectedEpisodeIndex;

  /// Select and play the specified episode
  void select(Episode episode);

  /// Switch to the next episode in the list
  void switchToNextEpisode();
}

@immutable
final class EpisodesWM implements IEpisodesWM {
  final TitleEpisodeSM _episodeSM;
  final IVideoPlayerNavigationInteractor _navigationInteractor;

  @override
  int? get selectedEpisodeIndex {
    final state = _episodeSM.state;
    final episode = state.episodeOrNull;
    if (episode == null) {
      return null;
    }

    final episodes = state.releaseOrNull?.episodes;
    return episodes?.indexOf(episode);
  }

  const EpisodesWM({
    required this._episodeSM,
    required this._navigationInteractor,
  });

  @override
  void select(Episode episode) {
    final state = _episodeSM.state;
    if (state.isProgress) {
      return;
    }

    final current = state.episodeOrNull;
    if (current?.uuid == episode.uuid) {
      return;
    }

    return _navigationInteractor.openVideoPlayer(episode.uuid);
  }

  @override
  void switchToNextEpisode() {
    final state = _episodeSM.state;
    if (state.isProgress) {
      return;
    }

    final current = state.episodeOrNull;
    final episodes = state.releaseOrNull?.episodes;
    if (episodes == null || current == null) {
      return;
    }

    final currentIndex = episodes.indexOf(current);
    if (currentIndex == -1) {
      return;
    }

    final next = episodes.elementAtOrNull(currentIndex + 1);
    if (next == null) {
      return;
    }

    _navigationInteractor.openVideoPlayer(next.uuid);
  }
}
