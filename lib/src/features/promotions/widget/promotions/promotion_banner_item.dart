import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:flutter/material.dart';

// TODO(wwwhttpru): I have to do this better
class PromotionBannerItem extends StatelessWidget {
  final MediaPromotionModel mediaPromotion;

  const PromotionBannerItem({required this.mediaPromotion, super.key});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Stack(
      fit: StackFit.expand,
      children: [
        _Poster(mediaPromotion.image),
        _Overlay(hasOverlay: mediaPromotion.hasOverlay),
        _ContentLayout(mediaPromotion: mediaPromotion),
      ],
    ),
  );
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel image;

  const _Poster(this.image);

  @override
  Widget build(BuildContext context) => StorageNetworkImage(
    src: image.optimized.src,
    thumbnail: image.optimized.thumbnail,
  );
}

class _Overlay extends StatelessWidget {
  final bool hasOverlay;

  const _Overlay({required this.hasOverlay});

  @override
  Widget build(BuildContext context) {
    if (!hasOverlay) {
      return const SizedBox.shrink();
    }

    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xD9101010), Color(0xD9000000)],
          stops: [0, 100],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}

class _ContentLayout extends StatelessWidget {
  final MediaPromotionModel mediaPromotion;

  const _ContentLayout({required this.mediaPromotion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.8,
                maxHeight: constraints.maxHeight,
              ),
              child: _TextLayout(
                title: mediaPromotion.title,
                subtitle: mediaPromotion.description,
                animeRelease: mediaPromotion.release,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _PlayButton(animeRelease: mediaPromotion.release),
          ),
        ],
      ),
    );
  }
}

class _TextLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final AnimeReleaseModel? animeRelease;

  const _TextLayout({
    required this.title,
    required this.subtitle,
    required this.animeRelease,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title ?? '',
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: Colors.white),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      _AnimeDescription(animeRelease: animeRelease),
      Text(
        subtitle ?? '',
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

class _AnimeDescription extends StatelessWidget {
  final AnimeReleaseModel? animeRelease;

  const _AnimeDescription({required this.animeRelease});

  @override
  Widget build(BuildContext context) {
    final value = animeRelease;

    if (value == null) {
      return const SizedBox(height: 24);
    }

    final title = value.yearSeasonTypeAgeLabel;
    final subtitle = value.genresLabel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final AnimeReleaseModel? animeRelease;

  const _PlayButton({required this.animeRelease});

  @override
  Widget build(BuildContext context) {
    final value = animeRelease;

    if (value == null) {
      return const SizedBox(height: 36);
    }

    return ElevatedButton.icon(
      onPressed: () => _onTap(context),
      label: const Text('Смотреть'),
      icon: const Icon(Icons.play_arrow, size: 20),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 36),
        fixedSize: const Size(120, 36),
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0x1affffff),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final alias = animeRelease?.alias;
    if (alias == null) {
      return;
    }

    // TODO(wwwhttpru): navigate by widget model
    final interactor = ReleasesScope.navigationInteractorOf(
      context,
      listen: false,
    );

    return interactor.openRelease(alias);
  }
}
