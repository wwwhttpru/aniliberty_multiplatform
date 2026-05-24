import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/router/catalog_route.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template catalog_navigation_module}
/// Navigation module for catalog feature.
/// {@endtemplate}
///
/// Registers routes for catalog screens.
class CatalogNavigationModule implements NavigationModule {
  /// {@macro catalog_route}
  final CatalogRoute _route;

  @override
  String get name => 'catalog';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.catalogTab,
      routeBuilder: RouteBuilder.outlet(
        outletBuilder: (context, routeNode, outlet) => CatalogScope(
          child: outlet,
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.catalogRelease,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const CatalogReleaseScreen(),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.catalogFilter,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory.modalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
        ),
        builder: (context, routeNode) => const CatalogFilterSheet(),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    InitializeSchemaNodeGuard(
      route: _route.catalogTab,
      builder: (node) {
        node.add(_route.catalogRelease.toNode());
        return node;
      },
    ),
  ];

  /// {@macro catalog_navigation_module}
  const CatalogNavigationModule({
    required this._route,
  });
}
