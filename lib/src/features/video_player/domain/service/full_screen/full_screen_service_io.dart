import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/i_full_screen_service.dart';
import 'package:flutter/services.dart';

/// Creates an instance of FullScreenService for IO platforms (iOS, Android, Desktop)
IFullScreenService createFullScreenService() => FullScreenServiceIO();

/// FullScreenService implementation for IO platforms
/// On mobile and desktop platforms, fullscreen mode is usually managed by
/// the system or through native calls, so a stub implementation is used here
final class FullScreenServiceIO implements IFullScreenService {
  final _fullscreenController = StreamController<bool>.broadcast();
  final _fullscreenSupportedController = StreamController<bool>.broadcast();
  bool _isFullscreen = false;

  @override
  Stream<bool> get fullscreenStream => _fullscreenController.stream;

  @override
  Stream<bool> get fullscreenSupportedStream =>
      _fullscreenSupportedController.stream;

  @override
  bool get isFullscreenSupported => true;

  @override
  bool get isFullscreen => _isFullscreen;

  FullScreenServiceIO();

  @override
  Future<void> init() {
    _setAllDevicesOrientation().ignore();
    return Future<void>.value();
  }

  @override
  Future<void> dispose() async {
    await _fullscreenController.close();
    await _fullscreenSupportedController.close();
    _setAllDevicesOrientation().ignore();
  }

  @override
  Future<void> toggleFullscreen() =>
      _isFullscreen ? exitFullscreen() : enterFullscreen();

  @override
  Future<void> enterFullscreen() async {
    await _setOnlyRightOrientation();
    if (_fullscreenController.isClosed) {
      return;
    }

    _isFullscreen = true;
    _fullscreenController.add(_isFullscreen);
  }

  @override
  Future<void> exitFullscreen() async {
    await _setAllDevicesOrientation();
    if (_fullscreenController.isClosed) {
      return;
    }

    _isFullscreen = false;
    _fullscreenController.add(_isFullscreen);
  }

  Future<void> _setAllDevicesOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

  Future<void> _setOnlyRightOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }
}
