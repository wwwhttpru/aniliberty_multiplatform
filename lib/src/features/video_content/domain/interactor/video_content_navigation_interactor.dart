import 'package:aniliberty_multiplatform/src/features/video_content/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for video content navigation operations.
///
/// Provides methods to open and close the video content screen.
abstract interface class IVideoContentNavigationInteractor {
  /// Opens the video content screen.
  ///
  /// If a video content route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openVideoContentAll();

  /// Closes the video content screen.
  ///
  /// Removes the video content route from the navigation stack if it exists.
  void closeVideoContentAll();
}

/// Implementation of [IVideoContentNavigationInteractor].
///
/// Manages navigation to and from the video content screen using
/// the YxNavigation routing system.
@immutable
class VideoContentNavigationInteractor
    implements IVideoContentNavigationInteractor {
  /// Route configuration for video content
  final VideoContentRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  /// Creates a new instance of [VideoContentNavigationInteractor].
  ///
  /// [_route] - The route configuration for video content screens
  /// [_controller] - The navigation controller for managing routes
  const VideoContentNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openVideoContentAll() => _openRoute(_route.videoContent);

  @override
  void closeVideoContentAll() => _closeRoute(_route.videoContent);

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
