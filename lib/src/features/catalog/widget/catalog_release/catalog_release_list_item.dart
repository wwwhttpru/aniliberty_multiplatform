import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:flutter/material.dart';

class CatalogReleaseListItem extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const CatalogReleaseListItem({
    required this.animeRelease,
    super.key,
  });

  // 220 image + 16 padding top + 16 padding bottom
  static double height = 220 + 24;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    shape: context.resolver.cardShape,
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      onTap: () => _onTap(context),
      borderRadius: context.resolver.cardBorderRadius,
      child: Padding(
        padding: const .all(12),
        child: SizedBox(
          height: 220,
          child: Row(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [
              _Poster(animeRelease.poster),
              Expanded(child: _AnimeDescription(animeRelease)),
            ],
          ),
        ),
      ),
    ),
  );

  void _onTap(BuildContext context) {
    final wm = CatalogScope.catalogReleaseWMOf(
      context,
      listen: false,
    );

    return wm.openRelease(animeRelease.alias);
  }
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel releasePoster;

  const _Poster(this.releasePoster);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: context.resolver.cardBorderRadius,
    child: SizedBox(
      width: 155,
      child: StorageNetworkImage(
        src: releasePoster.optimized.src,
        thumbnail: releasePoster.optimized.thumbnail,
      ),
    ),
  );
}

class _AnimeDescription extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _AnimeDescription(this.animeRelease);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    spacing: 10,
    children: [
      _Name(animeRelease.name),
      _YearSeasonAndGenres(animeRelease),
      Expanded(child: _Description(animeRelease.description)),
    ],
  );
}

class _Name extends StatelessWidget {
  final AnimeReleaseNameModel animeReleaseName;

  const _Name(this.animeReleaseName);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 2,
      children: [
        Text(
          animeReleaseName.main,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          animeReleaseName.english ?? '<unknown>',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _YearSeasonAndGenres extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _YearSeasonAndGenres(this.animeRelease);

  @override
  Widget build(BuildContext context) {
    final yearSeasonLabel = animeRelease.yearSeasonTypeAgeLabel;
    final genresLabel = animeRelease.genresLabel;

    if (yearSeasonLabel.isEmpty && genresLabel.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [_InfoChip(yearSeasonLabel), _InfoChip(genresLabel)],
    );
  }
}

class _Description extends StatelessWidget {
  final String? text;

  const _Description(this.text);

  @override
  Widget build(BuildContext context) {
    final value = text;

    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      value,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip(this.text);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: .circular(8),
        border: .all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const .symmetric(horizontal: 10, vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
