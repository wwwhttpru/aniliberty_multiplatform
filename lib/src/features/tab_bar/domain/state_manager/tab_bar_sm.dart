import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/entity/tab_bar_state.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/router/router.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_state/yx_state.dart';

/// {@template tab_bar_sm}
/// State manager for tab bar.
/// {@endtemplate}
class TabBarSM implements StateReadable<TabBarState> {
  /// Active route controller for managing routes
  // ignore: experimental_member_use
  final ActiveRouteController _routeIndexedNavigator;

  /// {@macro tab_bar_route}
  final TabBarRoute _route;

  /// {@macro tab_bar_sm}
  const TabBarSM({
    required this._routeIndexedNavigator,
    required this._route,
  });

  @override
  TabBarState get state => TabBarState(
    active: _tabFromNavigator(),
    tabs: TabBarTab.values,
  );

  @override
  Stream<TabBarState> get stream =>
      _routeIndexedNavigator.activeRouteStream.map((_) => state).distinct();

  TabBarTab _tabFromNavigator() {
    final route = _routeIndexedNavigator.activeRoute;

    if (route == null) {
      assert(route == null, 'Route must not be null');
      return TabBarTab.feed;
    }

    final tab = _route.fromRoute(route);
    if (tab == null) {
      assert(tab != null, 'Invalid route: $route');
      return TabBarTab.feed;
    }

    return tab;
  }
}
