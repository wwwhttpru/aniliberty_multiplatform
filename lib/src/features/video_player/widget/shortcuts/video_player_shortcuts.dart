import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

/// VideoPlayerShortcuts provides keyboard shortcuts for video player control.
class VideoPlayerShortcuts extends StatelessWidget {
  final Widget child;

  const VideoPlayerShortcuts({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final shortcuts = PlayerEpisodeScope.shortcutsOf(context);
    return Shortcuts(
      shortcuts: shortcuts.shortcuts,
      child: Actions(
        actions: shortcuts.actions,
        child: Focus(autofocus: true, child: child),
      ),
    );
  }
}
