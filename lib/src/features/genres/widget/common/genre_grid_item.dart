import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenreGridItem extends StatelessWidget {
  final AnimeGenreModel animeGenre;
  final VoidCallback onTap;

  const GenreGridItem({
    required this.animeGenre,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: context.resolver.cardBorderRadius,
    child: ClipRRect(
      borderRadius: context.resolver.cardBorderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _Poster(animeGenre.image),
          _Description(
            title: animeGenre.name,
            totalReleases: animeGenre.totalReleases,
          ),
        ],
      ),
    ),
  );
}

class _Poster extends StatelessWidget {
  final AnimeGenreImageModel image;

  const _Poster(this.image);

  @override
  Widget build(BuildContext context) => StorageNetworkImage(
    src: image.optimized.preview,
    thumbnail: image.optimized.thumbnail,
  );
}

class _Description extends StatelessWidget {
  final String title;
  final int totalReleases;

  const _Description({
    required this.title,
    required this.totalReleases,
  });

  @override
  Widget build(BuildContext context) => _Decoration(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 4,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          _subtitle(),
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  String _subtitle() {
    return Intl.plural(
      totalReleases,
      one: '$totalReleases релиз',
      few: '$totalReleases релиза',
      many: '$totalReleases релизов',
      other: '$totalReleases релизов', // Фолбэк
      locale: 'ru', // Указываем локаль
      name: 'ReleaseText',
      args: [totalReleases],
    );
  }
}

class _Decoration extends StatelessWidget {
  final Widget child;

  const _Decoration({required this.child});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 70, 100],
        colors: [
          Color.fromARGB(0, 16, 16, 16),
          Color.fromARGB(178, 16, 16, 16),
          Colors.black,
        ],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: child,
    ),
  );
}
