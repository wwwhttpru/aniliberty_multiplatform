import 'package:aniliberty_multiplatform/src/features/video_player/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum VideoShortcut {
  /// Play/Pause
  playPause,

  /// Seek forward
  seekForward,

  /// Seek backward
  seekBackward,

  /// Toggle fullscreen
  toggleFullscreen;

  /// Get the key of the shortcut
  LogicalKeyboardKey get key => switch (this) {
    VideoShortcut.playPause => LogicalKeyboardKey.space,
    VideoShortcut.seekForward => LogicalKeyboardKey.arrowRight,
    VideoShortcut.seekBackward => LogicalKeyboardKey.arrowLeft,
    VideoShortcut.toggleFullscreen => LogicalKeyboardKey.keyF,
  };

  /// Get the description of the shortcut
  String descriptionOf(BuildContext context) => switch (this) {
    VideoShortcut.playPause => 'Воспроизведение/Пауза',
    VideoShortcut.seekForward => 'Вперед на 15 секунд',
    VideoShortcut.seekBackward => 'Назад на 15 секунд',
    VideoShortcut.toggleFullscreen => 'Полноэкранный режим',
  };

  /// Get the label of the key
  String labelOf(BuildContext context) => switch (this) {
    VideoShortcut.playPause => 'Space',
    VideoShortcut.seekForward => '→',
    VideoShortcut.seekBackward => '←',
    VideoShortcut.toggleFullscreen => 'F',
  };
}

abstract interface class IVideoShortcuts {
  /// Get the map of keyboard shortcuts to intents
  Map<LogicalKeySet, Intent> get shortcuts;

  /// Get the map of intent types to actions
  Map<Type, Action<Intent>> get actions;
}

/// Service that provides keyboard shortcuts for video player control.
///
/// Supported shortcuts:
/// - Space: Play/Pause
/// - Left/Right arrows: Seek backward/forward (15 seconds)
/// - F key: Toggle fullscreen
class VideoShortcuts implements IVideoShortcuts {
  /// Map of keyboard shortcuts to intents
  final _shortcuts = <LogicalKeySet, Intent>{};

  /// Map of intent types to actions
  final _actions = <Type, Action<Intent>>{};

  /// Video player control widget model
  final IVideoPlayerControlWM controlWM;

  /// Get the map of keyboard shortcuts to intents
  @override
  Map<LogicalKeySet, Intent> get shortcuts => _shortcuts;

  /// Get the map of intent types to actions
  @override
  Map<Type, Action<Intent>> get actions => _actions;

  VideoShortcuts({required this.controlWM});

  Future<void> init() async {
    final newShortcuts = VideoShortcut.values.map(_createShortcut);
    final newActions = VideoShortcut.values.map(_createAction);

    _shortcuts.addEntries(newShortcuts);
    _actions.addEntries(newActions);
  }

  Future<void> dispose() async {
    _shortcuts.clear();
    _actions.clear();
  }

  MapEntry<LogicalKeySet, Intent> _createShortcut(VideoShortcut shortcut) {
    final keySet = switch (shortcut) {
      // Space bar - Play/Pause
      VideoShortcut.playPause => LogicalKeySet(shortcut.key),

      // Right arrow key - Seek forward
      VideoShortcut.seekForward => LogicalKeySet(shortcut.key),

      // Left arrow key - Seek backward
      VideoShortcut.seekBackward => LogicalKeySet(shortcut.key),

      // F key - Toggle fullscreen
      VideoShortcut.toggleFullscreen => LogicalKeySet(shortcut.key),
    };

    final intent = switch (shortcut) {
      VideoShortcut.playPause => const _PlayPauseIntent(),
      VideoShortcut.seekForward => const _SeekForwardIntent(),
      VideoShortcut.seekBackward => const _SeekBackwardIntent(),
      VideoShortcut.toggleFullscreen => const _ToggleFullscreenIntent(),
    };

    return MapEntry(keySet, intent);
  }

  MapEntry<Type, Action<Intent>> _createAction(VideoShortcut shortcut) {
    // ignore: omit_local_variable_types
    final Action<Intent> action = switch (shortcut) {
      VideoShortcut.playPause => _PlayPauseAction(controlWM: controlWM),
      VideoShortcut.seekForward => _SeekForwardAction(controlWM: controlWM),
      VideoShortcut.seekBackward => _SeekBackwardAction(controlWM: controlWM),
      VideoShortcut.toggleFullscreen => _ToggleFullscreenAction(
        controlWM: controlWM,
      ),
    };
    final intent = switch (shortcut) {
      VideoShortcut.playPause => _PlayPauseIntent,
      VideoShortcut.seekForward => _SeekForwardIntent,
      VideoShortcut.seekBackward => _SeekBackwardIntent,
      VideoShortcut.toggleFullscreen => _ToggleFullscreenIntent,
    };
    return MapEntry<Type, Action<Intent>>(intent, action);
  }
}

// Intent classes
class _PlayPauseIntent extends Intent {
  const _PlayPauseIntent();
}

class _SeekForwardIntent extends Intent {
  const _SeekForwardIntent();
}

class _SeekBackwardIntent extends Intent {
  const _SeekBackwardIntent();
}

class _ToggleFullscreenIntent extends Intent {
  const _ToggleFullscreenIntent();
}

// Action classes
class _PlayPauseAction extends Action<_PlayPauseIntent> {
  final IVideoPlayerControlWM controlWM;

  _PlayPauseAction({required this.controlWM});

  @override
  Object? invoke(_PlayPauseIntent intent) => controlWM.playOrPause();
}

class _SeekForwardAction extends Action<_SeekForwardIntent> {
  final IVideoPlayerControlWM controlWM;

  _SeekForwardAction({required this.controlWM});

  @override
  Object? invoke(_SeekForwardIntent intent) => controlWM.seekNext();
}

class _SeekBackwardAction extends Action<_SeekBackwardIntent> {
  final IVideoPlayerControlWM controlWM;

  _SeekBackwardAction({required this.controlWM});

  @override
  Object? invoke(_SeekBackwardIntent intent) => controlWM.seekPrev();
}

class _ToggleFullscreenAction extends Action<_ToggleFullscreenIntent> {
  final IVideoPlayerControlWM controlWM;

  _ToggleFullscreenAction({required this.controlWM});

  @override
  Object? invoke(_ToggleFullscreenIntent intent) =>
      controlWM.toggleFullscreen();
}
