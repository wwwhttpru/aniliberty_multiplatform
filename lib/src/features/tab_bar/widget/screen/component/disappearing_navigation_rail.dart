import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/consumer/tab_bar_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/scope/tab_bar_scope.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/component/disappearing_search_button.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/component/rail_theme_button.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/transition/nav_rail_transition.dart';
import 'package:flutter/material.dart';

class DisappearingNavigationRail extends StatelessWidget {
  /// Rail animation
  final RailAnimation railAnimation;

  /// Scale animation
  final RailFabAnimation railFabAnimation;

  const DisappearingNavigationRail({
    required this.railAnimation,
    required this.railFabAnimation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => NavRailTransition(
    animation: railAnimation,
    backgroundColor: Theme.of(context).colorScheme.surface,
    child: TabBarStateBuilder(
      builder: (context, state, _) => NavigationRail(
        destinations: state.tabs.map(_fromTab).toList(growable: false),
        selectedIndex: state.active.index,
        onDestinationSelected: (index) => _onTap(context, index),
        labelType: NavigationRailLabelType.all,
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: Padding(
          padding: const .only(top: 44),
          child: DisappearingSearchButton.rail(animation: railFabAnimation),
        ),
        trailing: const Padding(
          padding: .only(bottom: 56),
          child: RailThemeButton(),
        ),
        trailingAtBottom: true,
        scrollable: true,
      ),
    ),
  );

  NavigationRailDestination _fromTab(TabBarTab tab) => switch (tab) {
    TabBarTab.feed => const NavigationRailDestination(
      icon: Icon(Icons.home),
      label: Text('Главная'),
    ),
    TabBarTab.catalog => const NavigationRailDestination(
      icon: Icon(Icons.video_library_rounded),
      label: Text('Каталог'),
    ),
    TabBarTab.more => const NavigationRailDestination(
      icon: Icon(Icons.more_horiz),
      label: Text('Ещё'),
    ),
  };

  void _onTap(BuildContext context, int index) {
    final wm = TabBarScope.tabBarWMOf(
      context,
      listen: false,
    );
    return wm.onTabTap(index);
  }
}
