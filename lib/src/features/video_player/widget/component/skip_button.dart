import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) =>
      TitleEpisodeStateSelector<(Skips?, Skips?)>(
        selector: (state) {
          final episode = state.episodeOrNull;
          final opening = episode?.opening;
          final ending = episode?.ending;
          return (opening, ending);
        },
        builder: (context, skips, child) {
          const empty = SizedBox.shrink();

          if (skips.$1 == null && skips.$2 == null) {
            return empty;
          }

          return VideoPlayerInfoStateSelector<(bool, bool)>(
            selector: (state) => (
              _canSkip(state.position, skips.$1),
              _canSkip(state.position, skips.$2),
            ),
            builder: (context, canSkips, _) {
              const empty = SizedBox.shrink(key: ValueKey('skip_button_empty'));

              final child = switch (canSkips) {
                (true, _) => _SkipButton(
                  key: const ValueKey('skip_button_opening'),
                  onTap: () => _onTapOpening(context),
                ),
                (_, true) => _SkipButton(
                  key: const ValueKey('skip_button_ending'),
                  onTap: () => _onTapEnding(context),
                ),
                (_, _) => empty,
              };

              return AnimateSwitchLayout(child: child);
            },
            child: child,
          );
        },
      );

  bool _canSkip(Duration position, Skips? skips) {
    if (skips == null) {
      return false;
    }

    final start = skips.startSec;
    final end = skips.stopSec;
    return position.inSeconds >= start && position.inSeconds < end;
  }

  void _onTapOpening(BuildContext context) {
    final control = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );
    return control.skipOpening().ignore();
  }

  void _onTapEnding(BuildContext context) {
    final control = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );
    return control.skipEnding().ignore();
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SkipButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = colorScheme.onSurface.withValues(alpha: 0.24);
    final backgroundColor = colorScheme.surface.withValues(alpha: 0.54);
    final foregroundColor = colorScheme.onSurface;

    return ElevatedButton(
      onPressed: onTap,
      child: const Text('Пропустить'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: context.resolver.buttonBorderRadius,
          side: BorderSide(color: borderColor),
        ),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
