import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_module.dart';
import 'package:aniliberty_multiplatform/src/features/feed/router/feed_route.dart';
import 'package:aniliberty_multiplatform/src/features/feed/widget/widget.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/franchises.dart';
import 'package:aniliberty_multiplatform/src/features/genres/genres.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/promotions.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/schedule.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template feed_navigation_module}
/// Navigation module for feed feature.
/// {@endtemplate}
///
/// Registers routes for feed tab and feed screen.
class FeedNavigationModule implements NavigationModule {
  /// {@macro feed_route}
  final FeedRoute _route;

  @override
  String get name => 'feed';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.feedTab,
      routeBuilder: RouteBuilder.outlet(
        outletBuilder: (context, routeNode, outlet) => ScheduleScope(
          child: FranchisesScope(child: GenresScope(child: outlet)),
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.feed,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) =>
            const PromotionsScope(child: FeedScreen()),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    InitializeSchemaNodeGuard(
      route: _route.feedTab,
      builder: (node) {
        node.add(_route.feed.toNode());
        return node;
      },
    ),
  ];

  /// {@macro feed_navigation_module}
  const FeedNavigationModule({
    required this._route,
  });
}
