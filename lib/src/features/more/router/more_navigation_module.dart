import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/more/router/more_route.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template more_navigation_module}
/// Navigation module for more feature.
/// {@endtemplate}
///
/// Registers routes for more screens such as profile.
class MoreNavigationModule implements NavigationModule {
  /// {@macro more_route}
  final MoreRoute _route;

  @override
  String get name => 'more';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.moreTab,
      routeBuilder: RouteBuilder.outlet(
        outletBuilder: (context, routeNode, outlet) => MoreScope(
          child: outlet,
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.more,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const MoreScreen(),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    InitializeSchemaNodeGuard(
      route: _route.moreTab,
      builder: (node) {
        node.add(_route.more.toNode());
        return node;
      },
    ),
  ];

  const MoreNavigationModule({
    required this._route,
  });
}
