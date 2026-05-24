import 'dart:async';
import 'dart:js_interop';

import 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/i_full_screen_service.dart';
import 'package:web/web.dart' as web;

/// Creates an instance of FullScreenService for web platform
IFullScreenService createFullScreenService() => FullScreenServiceWeb();

/// FullScreenService implementation for web platform
final class FullScreenServiceWeb implements IFullScreenService {
  final _fullscreenController = StreamController<bool>.broadcast();
  final _fullscreenSupportedController = StreamController<bool>.broadcast();

  @override
  Stream<bool> get fullscreenStream => _fullscreenController.stream;

  @override
  Stream<bool> get fullscreenSupportedStream =>
      _fullscreenSupportedController.stream;

  FullScreenServiceWeb();

  @override
  Future<void> init() async => _startListenFullscreen();

  @override
  Future<void> dispose() async {
    _stopListenFullscreen();
    await _fullscreenController.close();
    await _fullscreenSupportedController.close();
  }

  void _startListenFullscreen() {
    try {
      web.document.addEventListener(
        'fullscreenchange',
        _onFullscreenChange.toJS,
      );
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  }

  void _stopListenFullscreen() {
    try {
      web.document.removeEventListener(
        'fullscreenchange',
        _onFullscreenChange.toJS,
      );
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  }

  void _onFullscreenChange() {
    // Update streams when state changes
    final currentFullscreen = isFullscreen;
    final currentSupported = isFullscreenSupported;
    _fullscreenController.add(currentFullscreen);
    _fullscreenSupportedController.add(currentSupported);
  }

  @override
  bool get isFullscreenSupported {
    try {
      final result = web.document.fullscreenEnabled;
      return result;
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
      return false;
    }
  }

  @override
  bool get isFullscreen {
    try {
      final result = web.document.fullscreenElement != null;
      return result;
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
      return false;
    }
  }

  @override
  Future<void> toggleFullscreen() async {
    try {
      final currentFullscreen = isFullscreen;
      if (currentFullscreen) {
        await exitFullscreen();
        return;
      }

      await enterFullscreen();
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  }

  @override
  Future<void> enterFullscreen() async {
    try {
      await web.document.documentElement?.requestFullscreen().toDart;
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  }

  @override
  Future<void> exitFullscreen() async {
    try {
      await web.document.exitFullscreen().toDart;
    } on Object catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  }
}
