import 'package:flutter/material.dart';

class EpisodesButton extends StatelessWidget {
  const EpisodesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: Scaffold.of(context).openDrawer,
      icon: const Icon(Icons.playlist_play),
      color: colorScheme.onSurface,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.38),
    );
  }
}
