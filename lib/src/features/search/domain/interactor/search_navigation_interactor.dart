import 'package:aniliberty_multiplatform/src/features/search/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for search navigation operations.
///
/// Provides methods to open and close the search screen.
abstract interface class ISearchNavigationInteractor {
  /// Opens the search screen.
  ///
  /// If a search route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openSearch();

  /// Closes the search screen.
  ///
  /// Removes the search route from the navigation stack if it exists.
  void closeSearch();
}

/// Implementation of [ISearchNavigationInteractor].
///
/// Manages navigation to and from the search screen using
/// the YxNavigation routing system.
@immutable
class SearchNavigationInteractor implements ISearchNavigationInteractor {
  /// Route configuration for search
  final SearchRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  /// Creates a new instance of [SearchNavigationInteractor].
  ///
  /// [_route] - The route configuration for search screens
  /// [_controller] - The navigation controller for managing routes
  const SearchNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openSearch() => _openRoute(_route.search);

  @override
  void closeSearch() => _closeRoute(_route.search);

  /// Opens a route if it doesn't already exist.
  ///
  /// If the route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void _openRoute(YxRoute route) {
    _controller.mutate(
      (routeNode) {
        // Check if route already exists
        final hasRoute = routeNode.find(
          (routeNode) => routeNode.route == route,
          recursive: false,
        );

        // Route already exists
        if (hasRoute != null) {
          return routeNode;
        }

        // Create new route node
        final value = RouteNode.fromRoute(
          route: route,
        );

        // Add new route node to current route node
        return routeNode..add(value);
      },
    );
  }

  /// Closes a route by removing it from the navigation stack.
  void _closeRoute(YxRoute route) => _controller.popWhere(
    (routeNode) => routeNode.route == route,
  );
}
