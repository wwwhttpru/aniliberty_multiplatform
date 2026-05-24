import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerControlWM {
  /// Start video playback
  Future<void> play();

  /// Pause video playback
  Future<void> pause();

  /// Toggle video playback (play or pause)
  Future<void> playOrPause();

  /// Seek video forward by 15 seconds
  Future<void> seekNext();

  /// Seek video backward by 15 seconds
  Future<void> seekPrev();

  /// Seek video to the specified [value] position
  Future<void> seekTo(Duration value);

  /// Skip the opening sequence
  Future<void> skipOpening();

  /// Skip the ending sequence
  Future<void> skipEnding();

  /// Toggle fullscreen mode
  Future<void> toggleFullscreen();
}

final class VideoPlayerControlWM implements IVideoPlayerControlWM {
  /// Video player controller manager
  final VideoPlayerControllerManager _controllerSM;

  /// Title episode state manager
  final TitleEpisodeSM _titleEpisodeSM;

  /// Full screen service
  final IFullScreenService _fullScreenService;

  VideoPlayerController get _controller {
    final controller = _controllerSM.state.maybeController;

    if (controller == null) {
      throw StateError('Controller must not be null');
    }

    return controller;
  }

  VideoPlayerControlWM({
    required this._controllerSM,
    required this._titleEpisodeSM,
    required this._fullScreenService,
  });

  @override
  Future<void> pause() => _controller.pause();

  @override
  Future<void> play() => _controller.play();

  @override
  Future<void> playOrPause() {
    if (_controller.value.isPlaying) {
      return pause();
    }

    return play();
  }

  @override
  Future<void> seekNext() {
    final current = _controller.value.position;
    final next = current + const Duration(seconds: 15);
    return _controller.seekTo(next);
  }

  @override
  Future<void> seekPrev() {
    final current = _controller.value.position;
    final next = current - const Duration(seconds: 15);
    return _controller.seekTo(next);
  }

  @override
  Future<void> seekTo(Duration value) async {
    final current = _controller.value.duration;

    if (value > current) {
      return;
    }

    return _controller.seekTo(value);
  }

  @override
  Future<void> skipOpening() {
    final episode = _titleEpisodeSM.state.episodeOrNull;
    final opening = episode?.opening;
    if (opening == null) {
      return Future<void>.value();
    }

    final end = opening.stopSec;
    return seekTo(Duration(seconds: end));
  }

  @override
  Future<void> skipEnding() {
    final episode = _titleEpisodeSM.state.episodeOrNull;
    final ending = episode?.ending;
    if (ending == null) {
      return Future<void>.value();
    }

    final stop = ending.stopSec;
    return seekTo(Duration(seconds: stop));
  }

  @override
  Future<void> toggleFullscreen() {
    if (!_fullScreenService.isFullscreenSupported) {
      return Future<void>.value();
    }
    return _fullScreenService.toggleFullscreen();
  }
}
