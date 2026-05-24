import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:flutter/material.dart';

class FranchiseReleaseInfoLayout extends StatelessWidget {
  final AnimeFranchiseReleaseModel animeFranchiseRelease;

  const FranchiseReleaseInfoLayout({
    required this.animeFranchiseRelease,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: () => _onTap(context),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _Poster(animeFranchiseRelease.release.poster),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _Info(animeFranchiseRelease),
            ),
          ),
          _SortNumber(animeFranchiseRelease.sortOrder),
        ],
      ),
    ),
  );

  void _onTap(BuildContext context) {
    // TODO(wwwhttpru): navigate by widget model
    final interactor = ReleasesScope.navigationInteractorOf(
      context,
      listen: false,
    );

    return interactor.openRelease(animeFranchiseRelease.release.alias);
  }
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel poster;

  const _Poster(this.poster);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: SizedBox.square(
      dimension: 80,
      child: StorageNetworkImage(
        src: poster.optimized.src,
        thumbnail: poster.optimized.thumbnail,
      ),
    ),
  );
}

class _Info extends StatelessWidget {
  final AnimeFranchiseReleaseModel animeFranchiseRelease;

  const _Info(this.animeFranchiseRelease);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        animeFranchiseRelease.release.name.main,
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        animeFranchiseRelease.release.name.english ?? '<unknown>',
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        animeFranchiseRelease.release.yearSeasonTypeAgeLabel,
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

class _SortNumber extends StatelessWidget {
  final int sortOrder;

  const _SortNumber(this.sortOrder);

  @override
  Widget build(BuildContext context) => Text(
    '#$sortOrder',
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
