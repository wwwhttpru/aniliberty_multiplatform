import 'package:aniliberty_multiplatform/src/features/auth/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for authentication navigation operations.
///
/// Provides methods to open and close the authentication screens.
abstract interface class IAuthNavigationInteractor {
  /// Opens the login screen.
  ///
  /// If a login route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openLogin();

  /// Closes the login screen.
  ///
  /// Removes the login route from the navigation stack if it exists.
  void closeLogin();

  /// Opens the forget password screen.
  ///
  /// If a forget password route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openForgetPassword();

  /// Closes the forget password screen.
  ///
  /// Removes the forget password route from the navigation stack if it exists.
  void closeForgetPassword();

  /// Opens the reset password screen.
  ///
  /// If a reset password route already exists, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  void openResetPassword();

  /// Closes the reset password screen.
  ///
  /// Removes the reset password route from the navigation stack if it exists.
  void closeResetPassword();
}

/// Implementation of [IAuthNavigationInteractor].
///
/// Manages navigation to and from the authentication screens using
/// the YxNavigation routing system.
@immutable
class AuthNavigationInteractor implements IAuthNavigationInteractor {
  /// Route configuration for authentication
  final AuthRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  const AuthNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openLogin() => _openRoute(_route.login);

  @override
  void closeLogin() => _closeRoute(_route.login);

  @override
  void openForgetPassword() => _openRoute(_route.forgetPassword);

  @override
  void closeForgetPassword() => _closeRoute(_route.forgetPassword);

  @override
  void openResetPassword() => _openRoute(_route.resetPassword);

  @override
  void closeResetPassword() => _closeRoute(_route.resetPassword);

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

        final allRoutes = _route.unauthenticatedRoutes;

        // Remove all routes with the same route
        routeNode.removeWhere(
          (routeNode) => allRoutes.contains(routeNode.route),
          recursive: false,
        );

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
