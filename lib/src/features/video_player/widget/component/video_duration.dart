import 'package:flutter/material.dart';

class VideoDuration extends StatelessWidget {
  final Duration duration;

  const VideoDuration({required this.duration, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      formatDuration(duration),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
