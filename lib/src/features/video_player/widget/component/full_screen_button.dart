import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class FullScreenButton extends StatelessWidget {
  const FullScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FullScreenStateBuilder(
      builder: (context, state) => IconButton(
        onPressed: state.isFullscreenSupported
            ? () => _onToggle(context)
            : null,
        icon: Icon(
          state.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
        ),
        color: colorScheme.onSurface,
        disabledColor: colorScheme.onSurface.withValues(alpha: 0.38),
      ),
    );
  }

  void _onToggle(BuildContext context) {
    final wm = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );
    return wm.toggleFullscreen().ignore();
  }
}
