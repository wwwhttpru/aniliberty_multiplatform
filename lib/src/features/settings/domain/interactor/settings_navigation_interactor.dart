import 'package:aniliberty_multiplatform/src/features/settings/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for settings navigation operations.
///
/// Provides methods to open and close the settings screens.
abstract interface class ISettingsNavigationInteractor {
  /// Opens the general settings screen.
  ///
  /// If a general settings route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openGeneralSettings();

  /// Closes the general settings screen.
  ///
  /// Removes the general settings route from the navigation stack if it exists.
  void closeGeneralSettings();

  /// Opens the video settings screen.
  ///
  /// If a video settings route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openVideoSettings();

  /// Closes the video settings screen.
  ///
  /// Removes the video settings route from the navigation stack if it exists.
  void closeVideoSettings();
}

/// Implementation of [ISettingsNavigationInteractor].
///
/// Manages navigation to and from the settings screens using
/// the YxNavigation routing system.
@immutable
class SettingsNavigationInteractor implements ISettingsNavigationInteractor {
  /// Route configuration for settings
  final SettingsRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  const SettingsNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openGeneralSettings() => _openRoute(_route.generalSettings);

  @override
  void closeGeneralSettings() => _closeRoute(_route.generalSettings);

  @override
  void openVideoSettings() => _openRoute(_route.videoSettings);

  @override
  void closeVideoSettings() => _closeRoute(_route.videoSettings);

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
