import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class ScheduleScope extends StatelessWidget {
  final Widget child;

  const ScheduleScope({required this.child, super.key});

  static ScheduleContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<ScheduleContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'ScheduleContainerOutputScope',
    );
  }

  static IScheduleNavigationInteractor navigationInteractorOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).navigationInteractor;

  static ScheduleNowSM scheduleNowSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).scheduleNowSM;

  static ScheduleWeekSM scheduleWeekSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).scheduleWeekSM;

  static IScheduleNowWM scheduleNowWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).scheduleNowWM;

  static IScheduleWeekWM scheduleWeekWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).scheduleWeekWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<ScheduleContainerOutputScope>(
        holder: AppScope.containerOf(context).scheduleContainerHolder,
        child: ScopeBuilder<ScheduleContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
