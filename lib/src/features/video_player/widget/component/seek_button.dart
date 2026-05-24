import 'package:flutter/material.dart';

enum SeekButtonDirection { prev, next }

class SeekButton extends StatelessWidget {
  final VoidCallback onTap;
  final SeekButtonDirection direction;
  final bool isProgress;

  const SeekButton({
    required this.onTap,
    required this.direction,
    required this.isProgress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: isProgress ? null : onTap,
      icon: switch (direction) {
        SeekButtonDirection.prev => const Icon(Icons.skip_previous),
        SeekButtonDirection.next => const Icon(Icons.skip_next),
      },
      color: colorScheme.onSurface,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.38),
    );
  }
}
