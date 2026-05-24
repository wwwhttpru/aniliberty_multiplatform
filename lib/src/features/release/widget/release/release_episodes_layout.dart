import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class ReleaseEpisodesLayout extends StatelessWidget {
  final AnimeReleaseModel releaseModel;

  const ReleaseEpisodesLayout({required this.releaseModel, super.key});

  @override
  Widget build(BuildContext context) {
    final episodes = releaseModel.episodes;

    if (episodes == null || episodes.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyLayout(),
      );
    }

    return SliverList.separated(
      itemCount: episodes.length,
      itemBuilder: (context, index) => _EpisodeListItem(
        key: ValueKey(episodes[index].id),
        episodeModel: episodes[index],
        onTap: () => open(context, episodes[index]),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  void open(BuildContext context, AnimeReleaseEpisodeModel episode) {
    final wm = ReleaseScope.releaseWMOf(
      context,
      listen: false,
    );

    return wm.openEpisode(episode.id);
  }
}

class _EpisodeListItem extends StatelessWidget {
  final AnimeReleaseEpisodeModel episodeModel;
  final VoidCallback onTap;

  const _EpisodeListItem({
    required this.episodeModel,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: context.resolver.splashBorderRadius,
    onTap: onTap,
    child: ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: _Poster(episodeModel.preview),
      title: Text(_name()),
      subtitle: episodeModel.nameEnglish != null
          ? Text(episodeModel.nameEnglish ?? '')
          : null,
    ),
  );

  String _name() {
    final name = episodeModel.name;

    if (name != null) {
      return name;
    }

    final ordinal = episodeModel.ordinal.toInt();
    return 'Эпизод $ordinal';
  }
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel preview;

  const _Poster(this.preview);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: context.resolver.splashBorderRadius,
    child: SizedBox.square(
      dimension: 48,
      child: StorageNetworkImage(
        src: preview.optimized.src,
        thumbnail: preview.optimized.thumbnail,
      ),
    ),
  );
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => const ListTile(
    contentPadding: EdgeInsets.all(8),
    leading: Icon(Icons.movie_outlined, size: 48),
    title: Text('Ни одного эпизода'),
    subtitle: Text(
      'На данный момент по такому '
      'запросу нет ни одного эпизода',
    ),
  );
}
