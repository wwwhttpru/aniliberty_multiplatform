import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';

/// {@template tab_bar_wm}
/// Widget model for the tab bar screen
/// {@endtemplate}
abstract interface class ITabBarWM {
  /// On tab tap
  void onTabTap(int index);
}

/// {@macro tab_bar_wm}
final class TabBarWM implements ITabBarWM {
  /// {@macro tab_bar_sm}
  final TabBarSM _tabBarSM;

  /// {@macro tab_bar_navigation_interactor}
  final ITabBarNavigationInteractor _navigationInteractor;

  /// {@macro tab_bar_wm}
  const TabBarWM({
    required this._tabBarSM,
    required this._navigationInteractor,
  });

  @override
  void onTabTap(int index) {
    final tab = _tabBarSM.state.tabs[index];
    final current = _tabBarSM.state.active;
    if (current == tab) {
      _navigationInteractor.popNestedRoute();
      return;
    }

    return switch (tab) {
      TabBarTab.feed => _navigationInteractor.goToFeed(),
      TabBarTab.catalog => _navigationInteractor.goToCatalog(),
      TabBarTab.more => _navigationInteractor.goToMore(),
    };
  }
}
