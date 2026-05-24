import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/router/schedule_route.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template schedule_navigation_module}
/// Navigation module for schedule feature.
///
/// Registers routes for schedule screens.
/// {@endtemplate}
@immutable
class ScheduleNavigationModule implements NavigationModule {
  /// {@macro schedule_route}
  final ScheduleRoute _route;

  @override
  String get name => 'schedule';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.scheduleWeek,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const ScheduleWeekScreen(),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  /// {@macro schedule_navigation_module}
  const ScheduleNavigationModule({
    required this._route,
  });
}
