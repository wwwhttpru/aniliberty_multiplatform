import 'package:aniliberty_multiplatform/src/features/tab_bar/router/tab_bar_route.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template tab_bar_guard}
/// Guard for tab bar route.
/// {@endtemplate}
@immutable
class TabBarGuard implements RouteNodeGuard {
  /// {@macro tab_bar_route}
  final TabBarRoute _route;

  /// {@macro tab_bar_guard}
  const TabBarGuard({
    required this._route,
  });

  @override
  GuardResult call(
    RouteNode origin,
    RouteNode target,
    GuardContext context,
  ) {
    final mutableTarget = target.toMutable();

    // Find parent node
    final parentNode = mutableTarget.findByRoute(_route.parentRoute);
    if (parentNode == null) {
      return const GuardResult.next();
    }

    // Find tab node and if it exists, return next
    final tabNode = parentNode.findByRoute(
      _route.tab,
      recursive: false,
    );

    if (tabNode != null) {
      return const GuardResult.next();
    }

    // Clear children and add new tab node
    parentNode.children.clear();
    parentNode.children.add(_route.tab.toMutableNode());

    // Redirect to target
    return GuardResult.redirect(target: mutableTarget);
  }
}
