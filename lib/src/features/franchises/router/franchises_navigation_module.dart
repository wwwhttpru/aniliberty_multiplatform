import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/router/franchises_route.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template franchises_navigation_module}
/// Navigation module for the franchises feature.
///
/// Registers routes for the franchises list and franchise detail screens.
/// {@endtemplate}
@immutable
class FranchisesNavigationModule implements NavigationModule {
  /// {@macro franchises_route}
  final FranchisesRoute _route;

  @override
  String get name => 'franchises';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.franchises,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const FranchisesAllScreen(),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.franchise,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) {
          final value = _route.getFranchiseIDFromMap(routeNode.arguments);

          if (value == null) {
            throw ArgumentError.value(value, 'franchiseId');
          }

          return FranchiseScope(
            franchiseId: value,
            child: const FranchiseScreen(),
          );
        },
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  /// {@macro franchises_navigation_module}
  const FranchisesNavigationModule({
    required this._route,
  });
}
