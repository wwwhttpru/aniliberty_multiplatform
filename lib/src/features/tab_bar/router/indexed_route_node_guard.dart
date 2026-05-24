import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

@immutable
class IndexedRouteNodeGuard implements RouteNodeGuard {
  /// Route of _tabRoute
  final YxRoute _tabRoute;

  /// List of required routes
  final Set<YxRoute> _routes;

  const IndexedRouteNodeGuard({
    required this._tabRoute,
    required this._routes,
  });

  @override
  GuardResult call(
    RouteNode origin,
    RouteNode target,
    GuardContext context,
  ) {
    final mutableTarget = target.toMutable();

    // Search _tabRoute in the target route node;
    final tabNode = mutableTarget.findByRoute(_tabRoute);
    if (tabNode == null) {
      return const GuardResult.next();
    }

    final shouldRedirect = shouldNeedRedirect(tabNode);
    if (!shouldRedirect) {
      return const GuardResult.next();
    }

    // Synchronize the list of children
    final children = _synchronizeRoutes(tabNode.children);
    tabNode.setChildren(children);

    return GuardResult.redirect(target: mutableTarget);
  }

  /// Returns true if the node needs to be updated
  bool shouldNeedRedirect(RouteNode tabRouteNode) {
    // Активный маршрут
    final activeRoute = tabRouteNode.children.lastOrNull?.route;
    if (activeRoute == null) {
      return true;
    }

    final isActiveRouteValid = _routes.contains(activeRoute);
    if (!isActiveRouteValid) {
      return true;
    }

    // Проверим что список маршрутов валидный
    final children = tabRouteNode.children;
    final routes = children.map((routeNode) => routeNode.route).toSet();

    final isRoutesValid = const SetEquality().equals(routes, _routes);
    return !isRoutesValid;
  }

  Iterable<MutableRouteNode> _synchronizeRoutes(
    Iterable<MutableRouteNode> children,
  ) {
    // Create map for fast access to existing children by route
    final currentNodes = <YxRoute, MutableRouteNode>{
      for (final child in children)
        if (_routes.contains(child.route)) child.route: child,
    };

    final result = <MutableRouteNode>[];

    // Add or create children according to _routes
    for (final route in _routes) {
      final node = currentNodes[route];
      if (node != null) {
        result.add(node);
      } else {
        result.add(route.toMutableNode());
      }
    }

    return result;
  }
}
