import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReleasesLatestAllScreen extends StatefulWidget {
  const ReleasesLatestAllScreen({super.key});

  @override
  State<ReleasesLatestAllScreen> createState() =>
      _ReleasesLatestAllScreenState();
}

class _ReleasesLatestAllScreenState extends State<ReleasesLatestAllScreen> {
  late final IReleasesLatestAllWM _releasesLatestAllWM;

  @override
  void initState() {
    super.initState();
    _releasesLatestAllWM = ReleasesScope.releasesLatestAllWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _releasesLatestAllWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ReleasesLatestAllStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.releases),
          error: (_) => ErrorLayout(onTap: _releasesLatestAllWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeReleasesModel animeReleases;

  const _SuccessLayout(this.animeReleases);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    slivers: [
      SliverPadding(
        padding: context.spacingAll.copyWith(bottom: 16),
        sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
      ),
      SliverPadding(
        padding: context.spacingH.copyWith(bottom: 16),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Новые эпизоды',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverPadding(
        padding: context.spacingH,
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 9 / 16,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final value = animeReleases.releases[index];
            return ReleaseGridItem(
              key: ValueKey(value.alias),
              animeRelease: value,
            );
          },
          itemCount: animeReleases.releases.length,
        ),
      ),
      SliverPadding(
        padding: context.spacingAll.copyWith(top: 16),
        sliver: const SliverToBoxAdapter(),
      ),
    ],
  );
}
