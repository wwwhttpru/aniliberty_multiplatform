import 'package:aniliberty_multiplatform/src/features/tab_bar/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template tab_bar_navigation_interactor}
/// Interface for tab bar navigation operations.
///
/// Provides methods to navigate between tabs.
/// {@endtemplate}
abstract interface class ITabBarNavigationInteractor {
  /// Go to feed screen
  void goToFeed();

  /// Go to catalog screen
  void goToCatalog();

  /// Go to more screen
  void goToMore();

  /// Pop nested route
  void popNestedRoute();
}

/// Implementation of [TabBarNavigationInteractor].
///
/// Manages navigation to and from the tab bar screens using
/// the YxNavigation routing system.
@immutable
class TabBarNavigationInteractor implements ITabBarNavigationInteractor {
  /// {@macro tab_bar_route}
  final TabBarRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  /// {@macro tab_bar_navigation_interactor}
  const TabBarNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void goToFeed() => _goTo(_route.feedTab);

  @override
  void goToCatalog() => _goTo(_route.catalogTab);

  @override
  void goToMore() => _goTo(_route.moreTab);

  @override
  void popNestedRoute() => _controller.mutate((routeNode) {
    final currentRoute = _controller.activeRoute;
    if (currentRoute == null) {
      return routeNode;
    }

    final activeRouteNode = routeNode.findByRoute(currentRoute);
    if (activeRouteNode == null) {
      return routeNode;
    }

    final length = activeRouteNode.children.length;
    if (length <= 1) {
      return routeNode;
    }

    activeRouteNode.children.removeLast();
    return routeNode;
  });

  /// Set active route
  void _goTo(YxRoute route) => _controller.setActiveRoute(route);
}
