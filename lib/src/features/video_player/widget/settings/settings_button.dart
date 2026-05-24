import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => _onPressed(context),
    icon: const Icon(Icons.settings),
    color: Theme.of(context).colorScheme.onSurface,
    disabledColor: Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.38),
  );

  void _onPressed(BuildContext context) {
    final wm = PlayerEpisodeScope.settingsWMOf(
      context,
      listen: false,
    );
    return wm.openSettings();
  }
}
