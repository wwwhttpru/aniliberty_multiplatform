import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/scope/search_scope.dart';
import 'package:flutter/material.dart';

class SearchReleaseListItem extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const SearchReleaseListItem({
    required this.animeRelease,
    super.key,
  });

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
    context: context,
    removeLeft: true,
    removeRight: true,
    child: ListTile(
      contentPadding: context.spacingH,
      shape: context.resolver.listTileShape,
      leading: _Poster(animeRelease.poster),
      title: Text(animeRelease.name.main),
      subtitle: Text(animeRelease.name.english ?? '<unknown>'),
      onTap: () => _onTap(context),
    ),
  );

  void _onTap(BuildContext context) {
    final wm = SearchScope.animeSearchWMOf(
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
    borderRadius: context.resolver.splashBorderRadius,
    child: SizedBox.square(
      dimension: 40,
      child: StorageNetworkImage(
        src: releasePoster.optimized.src,
        thumbnail: releasePoster.optimized.thumbnail,
      ),
    ),
  );
}
