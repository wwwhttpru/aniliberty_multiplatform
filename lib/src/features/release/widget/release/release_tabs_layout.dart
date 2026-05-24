import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/release/release_episodes_layout.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/release/release_members_layout.dart';
import 'package:flutter/material.dart';

class ReleaseTabsLayout extends StatelessWidget {
  const ReleaseTabsLayout({super.key});

  @override
  Widget build(BuildContext context) => TabBar(
    padding: EdgeInsets.zero,
    splashBorderRadius: context.resolver.splashBorderRadius,
    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    indicatorSize: TabBarIndicatorSize.tab,
    dividerHeight: 0,
    tabs: const [
      Tab(text: 'Эпизоды'),
      Tab(text: 'Связанное'),
      Tab(text: 'Работа над релизом'),
      Tab(text: 'Торренты'),
    ],
  );
}

class ReleaseTabsBodyLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const ReleaseTabsBodyLayout({required this.animeRelease, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final index = controller.index;

        switch (index) {
          case 0:
            return ReleaseEpisodesLayout(releaseModel: animeRelease);
          case 1:
            // TODO(wwwhttpru): implements
            return const _EmptyLayout();
          case 2:
            return ReleaseMembersLayout(releaseModel: animeRelease);
          case 3:
            // TODO(wwwhttpru): implements
            return const _EmptyLayout();
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => const SliverFillRemaining(
    hasScrollBody: false,
    child: ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: Icon(Icons.construction_outlined, size: 48),
      title: Text('Раздел в разработке'),
      subtitle: Text('Сделаем этот раздел в ближайшее время'),
    ),
  );
}
