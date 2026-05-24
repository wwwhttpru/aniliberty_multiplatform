import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/router/app_status_route.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template app_status_navigation_module}
/// Navigation module for app status feature.
/// {@endtemplate}
///
/// Registers routes for app status screens.
class AppStatusNavigationModule implements NavigationModule {
  /// {@macro app_status_route}
  final AppStatusRoute _route;

  /// {@macro app_status_container_output_scope}
  final AppStatusContainerOutputScope _container;

  @override
  String get name => 'app-status';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.appStatus,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => AppStatusScope(
          container: _container,
          child: const AppStatusScreen(),
        ),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  const AppStatusNavigationModule({
    required this._route,
    required this._container,
  });
}
