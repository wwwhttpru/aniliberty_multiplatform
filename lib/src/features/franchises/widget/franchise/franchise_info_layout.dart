import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:flutter/material.dart';

class FranchiseInfoLayout extends StatelessWidget {
  final AnimeFranchiseModel animeFranchise;

  const FranchiseInfoLayout({required this.animeFranchise, super.key});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _Poster(animeFranchise.image),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _Info(animeFranchise),
            ),
          ),
        ],
      ),
    ),
  );
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
  final AnimeFranchiseModel animeFranchise;

  const _Info(this.animeFranchise);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        animeFranchise.name,
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        animeFranchise.nameEnglish,
        textAlign: TextAlign.start,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        animeFranchise.allInfoLabel,
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
