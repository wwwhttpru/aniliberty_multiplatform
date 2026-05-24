import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Route configuration for authentication screens.
///
/// Provides route definitions and utilities for navigating to authentication
/// screens such as login.
@immutable
class AuthRoute {
  /// Login screen ID
  YxRoute get login => const YxRoute(id: 'login');

  /// Forget password screen ID
  YxRoute get forgetPassword => const YxRoute(id: 'forgetPassword');

  /// Reset password screen ID
  YxRoute get resetPassword => const YxRoute(id: 'resetPassword');

  /// Return routes which available for unauthenticated users.
  Set<YxRoute> get unauthenticatedRoutes => {
    login,
    forgetPassword,
    resetPassword,
  };

  const AuthRoute();
}
