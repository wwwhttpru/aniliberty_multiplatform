import 'package:aniliberty_multiplatform/src/features/app_status/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for app status navigation operations.
///
/// Provides methods to open and close the app status screen.
abstract interface class IAppStatusNavigationInteractor {
  /// Opens the app status screen.
  ///
  /// If an app status route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openAppStatus();

  /// Closes the app status screen.
  ///
  /// Removes the app status route from the navigation stack if it exists.
  void closeAppStatus();
}

/// Implementation of [IAppStatusNavigationInteractor].
///
/// Manages navigation to and from the app status screen using
/// the YxNavigation routing system.
@immutable
class AppStatusNavigationInteractor implements IAppStatusNavigationInteractor {
  /// Route configuration for app status
  final AppStatusRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  const AppStatusNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openAppStatus() => _openRoute(_route.appStatus);

  @override
  void closeAppStatus() => _closeRoute(_route.appStatus);

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
