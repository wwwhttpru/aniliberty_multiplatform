import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/release/router/release_route.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template releases_navigation_module}
/// Navigation module for releases feature.
///
/// Registers routes for release screens.
/// {@endtemplate}
@immutable
class ReleasesNavigationModule implements NavigationModule {
  /// {@macro release_route}
  final ReleaseRoute _route;

  @override
  String get name => 'releases';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.releaseLatestAll,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const ReleasesLatestAllScreen(),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.release,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) {
          final value = _route.getAliasOrIDFromMap(routeNode.arguments);

          if (value == null) {
            throw ArgumentError.value(value, 'AliasOrId');
          }

          return ReleaseScope(
            aliasOrId: value,
            child: const ReleaseScreen(),
          );
        },
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  /// {@macro releases_navigation_module}
  const ReleasesNavigationModule({
    required this._route,
  });
}
