import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/episode.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/video_quality.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state_manager/title_episode_sm.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state_manager/video_player_controller_manager.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state_manager/video_player_sm.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/state_manager/video_quality_sm.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// Interactor that manages video player episode playback.
///
/// This interactor listens to changes in the selected episode and automatically
/// updates the video player controller with the appropriate HLS stream URL.
/// It handles episode selection, stream quality fallback (HD -> SD -> FHD),
/// and player state management.
final class PlayerEpisodeInteractor {
  /// State manager for the selected episode
  final TitleEpisodeSM _titleEpisodeSM;

  /// State manager for the selected video quality
  final VideoQualitySM _videoQualitySM;

  /// State manager for the video player info
  final VideoPlayerInfoSM _videoPlayerInfoSM;

  /// Manager for the video player controller
  final VideoPlayerControllerManager _controllerManager;

  /// Subscription to changes in the selected episode or video quality
  StreamSubscription<void>? _subscription;

  PlayerEpisodeInteractor({
    required this._titleEpisodeSM,
    required this._videoQualitySM,
    required this._videoPlayerInfoSM,
    required this._controllerManager,
  });

  /// Initializes the interactor and starts listening to episode changes.
  ///
  /// Sets up a stream subscription to monitor changes in the selected episode
  /// and automatically update the video player when the episode changes.
  @mustCallSuper
  Future<void> initialize() {
    assert(_subscription == null, 'subscription must be null');

    final episode = _titleEpisodeSM.stream
        .startWith(_titleEpisodeSM.state)
        .map((value) => value.episodeOrNull)
        .distinct();

    final quality = _videoQualitySM.stream
        .startWith(_videoQualitySM.state)
        .map((value) => value.qualityOrNull)
        .distinct();

    _subscription = Rx.combineLatest2(
      episode,
      quality,
      (a, b) => (episode: a, quality: b),
    ).distinct().listen((value) => _onData(value.episode, value.quality));

    return Future<void>.value();
  }

  /// Closes the interactor and cancels all subscriptions.
  ///
  /// Should be called when the interactor is no longer needed to prevent
  /// memory leaks.
  @mustCallSuper
  Future<void> close() async {
    assert(_subscription != null, 'subscription must not be null');
    await _subscription?.cancel();
    _subscription = null;
  }

  /// Called when the selected episode changes.
  ///
  /// Updates the video player controller with the new episode's HLS stream.
  /// Uses quality fallback: HD -> SD -> FHD if available.
  /// Sets the player to empty state if no episode is selected or no stream is available.
  void _onData(Episode? episode, VideoQuality? quality) {
    // No episode selected, set empty placeholder
    if (episode == null) {
      _controllerManager.setEmpty();
      return;
    }

    // No quality selected, set empty placeholder
    if (quality == null) {
      _controllerManager.setEmpty();
      return;
    }

    final pathFromQuality = switch (quality) {
      VideoQuality.hd => episode.hls.hd,
      VideoQuality.sd => episode.hls.sd,
      VideoQuality.fhd => episode.hls.fhd,
    };

    // Quality fallback: HD -> SD -> FHD
    final hls = episode.hls;
    final path = pathFromQuality ?? hls.hd ?? hls.sd ?? hls.fhd;
    if (path == null) {
      _controllerManager.setEmpty();
      return;
    }

    final info = _videoPlayerInfoSM.state;
    final uri = Uri.parse(path);

    _controllerManager.setHlsUri(uri, position: info.position);
  }
}
