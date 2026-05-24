import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/router/auth_route.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template auth_guard}
/// Guard for auth route.
///
/// Validates authentication routes and ensures proper navigation flow.
/// {@endtemplate}
class AuthGuard implements RouteNodeGuard {
  /// {@macro auth_sm}
  final AuthSM _authSM;

  /// {@macro auth_route}
  final AuthRoute _authRoute;

  /// {@macro auth_guard}
  const AuthGuard({
    required this._authSM,
    required this._authRoute,
  });

  @override
  GuardResult call(
    RouteNode origin,
    RouteNode target,
    GuardContext context,
  ) {
    // Check if user is authenticated
    final isAuthenticated = _authSM.state.isAuthenticated;

    // If user is not authenticated, allow navigation to auth routes
    if (!isAuthenticated) {
      return const GuardResult.next();
    }

    final notAllowedRoutes = _authRoute.unauthenticatedRoutes;
    final routeNode = target.find(
      (routeNode) => notAllowedRoutes.contains(routeNode.route),
    );

    if (routeNode != null) {
      return const GuardResult.cancel();
    }

    return const GuardResult.next();
  }
}
