import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template schedule_route}
/// Route configuration for schedule screens.
///
/// Provides route definitions and utilities for navigating to schedule screens.
/// {@endtemplate}
@immutable
class ScheduleRoute {
  /// Schedule week screen ID.
  YxRoute get scheduleWeek => const YxRoute(id: 'schedule-week');

  /// {@macro schedule_route}
  const ScheduleRoute();
}
