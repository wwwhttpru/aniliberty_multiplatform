import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/router/auth_guard.dart';
import 'package:aniliberty_multiplatform/src/features/auth/router/auth_route.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template auth_navigation_module}
/// Navigation module for authentication feature.
/// {@endtemplate}
///
/// Registers routes for authentication screens such as login.
class AuthNavigationModule implements NavigationModule {
  /// {@macro auth_route}
  final AuthRoute _route;

  /// {@macro login_container_sm}
  final LoginContainerSM _loginContainerSM;

  /// {@macro forget_password_container_sm}
  final ForgetPasswordContainerSM _forgetPasswordContainerSM;

  /// {@macro reset_password_container_sm}
  final ResetPasswordContainerSM _resetPasswordContainerSM;

  /// {@macro auth_sm}
  final AuthSM _authSM;

  @override
  String get name => 'auth';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.login,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory<void>.material(
          fullscreenDialog: true,
        ),
        builder: (context, routeNode) => AuthLoginScope(
          loginContainerSM: _loginContainerSM,
          child: const AuthLoginScreen(),
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.forgetPassword,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory<void>.material(
          fullscreenDialog: true,
        ),
        builder: (context, routeNode) => AuthForgetPasswordScope(
          forgetPasswordContainerSM: _forgetPasswordContainerSM,
          child: const AuthForgetPasswordScreen(),
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.resetPassword,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory<void>.material(
          fullscreenDialog: true,
        ),
        builder: (context, routeNode) => AuthResetPasswordScope(
          resetPasswordContainerSM: _resetPasswordContainerSM,
          child: const AuthResetPasswordScreen(),
        ),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    AuthGuard(
      authSM: _authSM,
      authRoute: _route,
    ),
  ];

  const AuthNavigationModule({
    required this._route,
    required this._loginContainerSM,
    required this._forgetPasswordContainerSM,
    required this._resetPasswordContainerSM,
    required this._authSM,
  });
}
