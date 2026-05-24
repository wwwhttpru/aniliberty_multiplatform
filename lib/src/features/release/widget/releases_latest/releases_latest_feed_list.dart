import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/feed/feed.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';

class ReleasesLatestFeedList extends StatefulWidget {
  const ReleasesLatestFeedList({super.key});

  @override
  State<ReleasesLatestFeedList> createState() => _ReleasesLatestFeedListState();
}

class _ReleasesLatestFeedListState extends State<ReleasesLatestFeedList> {
  late final IReleasesLatestWM _releasesLatestWM;

  @override
  void initState() {
    super.initState();
    _releasesLatestWM = ReleasesScope.releasesLatestWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _releasesLatestWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => FeedCategoryItem(
    title: 'Новые эпизоды',
    subtitle: 'Самые новые и свежие эпизоды в любимой озвучке',
    onTap: _releasesLatestWM.openAll,
    child: ReleasesLatestStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.releases),
          error: (_) => ErrorLayout(onTap: _releasesLatestWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeReleasesModel animeReleases;

  const _SuccessLayout(this.animeReleases);

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemBuilder: (context, index) {
      final value = animeReleases.releases[index];
      return ReleaseGridItem(key: ValueKey(value.id), animeRelease: value);
    },
    itemCount: animeReleases.releases.length,
  );
}

class _HorizontalListLayout extends StatelessWidget {
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const _HorizontalListLayout({
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: context.spacingH,
    itemCount: itemCount,
    itemBuilder: (context, index) {
      final child = itemBuilder(context, index);
      return SizedBox(width: 180, child: child);
    },
    separatorBuilder: (context, index) =>
        const SizedBox(width: FeedCategoryItem.hPadding),
  );
}
