import 'package:aniliberty_multiplatform/src/features/schedule/router/schedule_route.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

abstract interface class IScheduleNavigationInteractor {
  /// Открыть список новых эпизодов
  void openSchedules();
}

@immutable
class ScheduleNavigationInteractor implements IScheduleNavigationInteractor {
  final NavigationController _controller;
  final ScheduleRoute _route;

  const ScheduleNavigationInteractor({
    required this._controller,
    required this._route,
  });

  @override
  void openSchedules() {
    final route = _route.scheduleWeek;

    final routeNode = _controller.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _controller.push(route);
  }
}
