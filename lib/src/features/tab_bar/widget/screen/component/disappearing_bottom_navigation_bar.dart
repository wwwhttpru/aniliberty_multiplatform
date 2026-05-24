import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/consumer/tab_bar_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/scope/tab_bar_scope.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/transition/bottom_bar_transition.dart';
import 'package:flutter/material.dart';

class DisappearingBottomNavigationBar extends StatelessWidget {
  final BarAnimation barAnimation;

  const DisappearingBottomNavigationBar({
    required this.barAnimation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BottomBarTransition(
    animation: barAnimation,
    child: TabBarStateBuilder(
      builder: (context, state, _) => NavigationBar(
        destinations: state.tabs
            .map<NavigationDestination>(_navigationDestination)
            .toList(growable: false),
        onDestinationSelected: (index) => _onTap(context, index),
        selectedIndex: state.active.index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
      ),
    ),
  );

  NavigationDestination _navigationDestination(TabBarTab tab) {
    switch (tab) {
      case TabBarTab.feed:
        return const NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Главная',
        );
      case TabBarTab.catalog:
        return const NavigationDestination(
          icon: Icon(Icons.video_library_rounded),
          label: 'Каталог',
        );
      case TabBarTab.more:
        return const NavigationDestination(
          icon: Icon(Icons.more_horiz),
          label: 'Ещё',
        );
    }
  }

  void _onTap(BuildContext context, int index) {
    final wm = TabBarScope.tabBarWMOf(
      context,
      listen: false,
    );
    return wm.onTabTap(index);
  }
}
