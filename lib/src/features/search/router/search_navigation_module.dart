import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/search/router/search_route.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template search_navigation_module}
/// Navigation module for search feature.
/// {@endtemplate}
///
/// Registers routes for search screens.
class SearchNavigationModule implements NavigationModule {
  /// {@macro search_route}
  final SearchRoute _route;

  @override
  String get name => 'search';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.search,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory<void>.material(
          fullscreenDialog: true,
        ),
        builder: (context, routeNode) => const SearchReleasesScreen(),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [];

  /// {@macro search_navigation_module}
  const SearchNavigationModule({
    required this._route,
  });
}
