import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class EpisodeListTile extends StatelessWidget {
  final Episode episode;
  final bool isSelected;

  const EpisodeListTile({
    required this.episode,
    required this.isSelected,
    super.key,
  });

  static const double height = 64;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    bottom: false,
    minimum: context.spacingH,
    child: SizedBox(
      height: height,
      child: ListTile(
        shape: context.resolver.listTileShape,
        contentPadding: context.spacingH,
        title: Text('Эпизод ${episode.episode.toInt()}'),
        titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        subtitle: Text(episode.name, maxLines: 2),
        subtitleTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
        ),
        onTap: () => onTap(context),
        trailing: isSelected ? const _Trailing() : const SizedBox.shrink(),
        dense: false,
        isThreeLine: false,
        minTileHeight: height,
        selected: isSelected,
      ),
    ),
  );

  void onTap(BuildContext context) {
    final wm = PlayerEpisodeScope.episodesWMOf(
      context,
      listen: false,
    );

    return wm.select(episode);
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing();

  @override
  Widget build(BuildContext context) => Icon(
    Icons.play_arrow_rounded,
    size: 24,
    color: Theme.of(context).colorScheme.primary,
  );
}
