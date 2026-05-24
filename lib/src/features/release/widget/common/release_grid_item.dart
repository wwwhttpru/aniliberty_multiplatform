import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:flutter/material.dart';

class ReleaseGridItem extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const ReleaseGridItem({required this.animeRelease, super.key});

  @override
  Widget build(BuildContext context) => _ItemLayout(animeRelease);
}

class _ItemLayout extends StatefulWidget {
  final AnimeReleaseModel animeRelease;

  const _ItemLayout(this.animeRelease);

  @override
  State<_ItemLayout> createState() => _ItemLayoutState();
}

class _ItemLayoutState extends State<_ItemLayout> {
  late final ValueNotifier<bool> _isHoverNotifier;

  @override
  void initState() {
    super.initState();
    _isHoverNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isHoverNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: _onTap,
    onHover: _onHover,
    borderRadius: BorderRadius.circular(8),
    child: ValueListenableBuilder<bool>(
      valueListenable: _isHoverNotifier,
      builder: (context, isHover, poster) {
        var child = poster ?? const SizedBox.shrink();

        final color = isHover ? Colors.black87 : Colors.transparent;
        child = _ForegroundLayout(
          animeRelease: widget.animeRelease,
          isVisible: isHover,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            foregroundDecoration: BoxDecoration(color: color),
            child: child,
          ),
        );

        return ClipRRect(borderRadius: BorderRadius.circular(8), child: child);
      },
      child: _Poster(widget.animeRelease.poster),
    ),
  );

  void _onHover(bool isHover) => _isHoverNotifier.value = isHover;

  void _onTap() {
    // TODO(wwwhttpru): navigate by widget model
    final interactor = ReleasesScope.navigationInteractorOf(
      context,
      listen: false,
    );

    return interactor.openRelease(widget.animeRelease.alias);
  }
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel releasePoster;

  const _Poster(this.releasePoster);

  @override
  Widget build(BuildContext context) => StorageNetworkImage(
    src: releasePoster.optimized.src,
    thumbnail: releasePoster.optimized.thumbnail,
  );
}

class _ForegroundLayout extends StatelessWidget {
  final Widget child;
  final AnimeReleaseModel animeRelease;
  final bool isVisible;

  const _ForegroundLayout({
    required this.child,
    required this.animeRelease,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      child,
      AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        child: _ReleaseDescription(animeRelease),
      ),
    ],
  );
}

class _ReleaseDescription extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _ReleaseDescription(this.animeRelease);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Name(animeRelease.name),
        const SizedBox(height: 8),
        _YearSeasonAndGenres(animeRelease),
      ],
    ),
  );
}

class _Name extends StatelessWidget {
  final AnimeReleaseNameModel releaseName;

  const _Name(this.releaseName);

  @override
  Widget build(BuildContext context) => Text(
    releaseName.main,
    textAlign: TextAlign.center,
    style: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
    maxLines: 5,
    overflow: TextOverflow.ellipsis,
  );
}

class _YearSeasonAndGenres extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _YearSeasonAndGenres(this.animeRelease);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    spacing: 12,
    children: [
      Text(
        animeRelease.yearSeasonTypeAgeLabel,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.white60),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        animeRelease.genresLabel,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.white60),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
