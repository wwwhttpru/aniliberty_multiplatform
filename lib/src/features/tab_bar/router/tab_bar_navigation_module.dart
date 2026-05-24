import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/router/indexed_route_node_guard.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/router/tab_bar_guard.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/router/tab_bar_route.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template tab_bar_navigation_module}
/// Navigation module for tab bar feature.
///
/// Registers routes for tab bar and its child tabs.
/// {@endtemplate}
class TabBarNavigationModule implements NavigationModule {
  /// {@macro tab_bar_route}
  final TabBarRoute _route;

  @override
  String get name => 'tab-bar';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.tab,
      routeBuilder: RouteBuilder.indexed(
        indexedBuilder: (context, routeNode, child, _) => TabBarScope(
          child: TabBarScreen(child: child),
        ),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    TabBarGuard(route: _route),
    IndexedRouteNodeGuard(
      tabRoute: _route.tab,
      routes: _route.allTabs,
    ),
  ];

  /// {@macro tab_bar_navigation_module}
  const TabBarNavigationModule({
    required this._route,
  });
}
