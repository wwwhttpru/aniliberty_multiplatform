import 'dart:async';

import 'package:aniliberty_multiplatform/src/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ISettingsWM {
  /// Select video quality
  void selectQuality(VideoQuality quality);

  /// Open settings screen
  void openSettings();

  /// Close settings screen
  void closeSettings();
}

final class SettingsWM implements ISettingsWM {
  final VideoQualitySM _videoQualitySM;
  final TitleEpisodeSM _titleEpisodeSM;
  final IVideoPlayerNavigationInteractor _navigationInteractor;

  /// Subscription to video quality changes
  StreamSubscription<(VideoQuality?, VideoQuality)?>? _onQualityChangedSub;

  SettingsWM({
    required this._videoQualitySM,
    required this._titleEpisodeSM,
    required this._navigationInteractor,
  });

  Future<void> init() async {
    assert(
      _onQualityChangedSub == null,
      'On quality changed sub must be null',
    );

    _onQualityChangedSub = _videoQualitySM.stream
        .map((event) => event.qualityOrNull)
        .startWith(_videoQualitySM.state.qualityOrNull)
        .whereNotNull()
        .distinct()
        .preview()
        .listen((event) => _onQualityChanged(event.$1, event.$2));
  }

  Future<void> dispose() async {
    assert(
      _onQualityChangedSub != null,
      'On quality changed sub must not be null',
    );
    await _onQualityChangedSub?.cancel();
    _onQualityChangedSub = null;
  }

  @override
  void selectQuality(VideoQuality quality) {
    _videoQualitySM.selectQuality(quality);
  }

  @override
  void openSettings() {
    final episode = _titleEpisodeSM.state.episodeOrNull;
    if (episode == null) {
      return;
    }

    _navigationInteractor.openSettings(episode.uuid);
  }

  @override
  void closeSettings() {
    final episode = _titleEpisodeSM.state.episodeOrNull;
    if (episode == null) {
      return;
    }

    _navigationInteractor.closeSettings(episode.uuid);
  }

  void _onQualityChanged(VideoQuality? previous, VideoQuality current) {
    if (previous == null || previous == current) {
      return;
    }

    closeSettings();
  }
}
