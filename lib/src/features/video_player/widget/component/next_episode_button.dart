import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class NextEpisodeButton extends StatelessWidget {
  const NextEpisodeButton({super.key});

  @override
  Widget build(BuildContext context) => TitleEpisodeStateBuilder(
    builder: (context, state, child) {
      final episodes = state.releaseOrNull?.episodes;
      final episode = state.episodeOrNull;

      // If episodes or episode are not loaded, return empty widget
      if (episodes == null || episode == null) {
        return const SizedBox.shrink();
      }

      // If current episode is the last episode, return empty widget
      final isLastEpisode = _isLastEpisode(episodes, episode);
      if (isLastEpisode) {
        return const SizedBox.shrink();
      }

      return VideoPlayerInfoStateSelector(
        selector: (state) => _shouldShow(state, episode),
        builder: (context, shouldShow, child) {
          const empty = SizedBox.shrink(
            key: ValueKey('next_episode_button_empty'),
          );

          final child = switch (shouldShow) {
            true => _NextEpisodeButton(
              key: const ValueKey('next_episode_button'),
              onTap: () => _onTapNextEpisode(context),
            ),
            false => empty,
          };

          return AnimateSwitchLayout(child: child);
        },
      );
    },
  );

  /// Check if there is a next episode
  bool _isLastEpisode(List<Episode> episodes, Episode episode) {
    final current = episode.uuid;
    final last = episodes.lastOrNull?.uuid;
    return current == last;
  }

  /// Check if the next episode button should be shown
  ///
  /// [value] - The current state of the video player
  /// [episode] - The current episode
  ///
  /// Returns true if the next episode button should be shown, false otherwise.
  bool _shouldShow(VideoPlayerState value, Episode episode) {
    final ending = episode.ending;

    // If the ending is not set, then show button if position reaches 95% of duration
    if (ending == null) {
      final startSec = value.duration.inSeconds * 0.95;
      return value.position.inSeconds >= startSec;
    }

    return value.position.inSeconds >= ending.startSec;
  }

  void _onTapNextEpisode(BuildContext context) {
    final control = PlayerEpisodeScope.episodesWMOf(
      context,
      listen: false,
    );
    return control.switchToNextEpisode();
  }
}

class _NextEpisodeButton extends StatelessWidget {
  final VoidCallback onTap;

  const _NextEpisodeButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final borderColor = primaryColor.withValues(alpha: 0.5);
    final backgroundColor = primaryColor.withValues(alpha: 0.8);
    final foregroundColor = colorScheme.onPrimary;

    return ElevatedButton(
      onPressed: onTap,
      child: const Text('Следующий эпизод'),
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
