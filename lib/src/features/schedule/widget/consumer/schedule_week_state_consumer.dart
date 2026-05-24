import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ScheduleWeekStateConsumer extends StatelessWidget {
  final StateWidgetListener<ScheduleWeekState> listener;
  final StateWidgetBuilder<ScheduleWeekState> builder;
  final StateListenerCondition<ScheduleWeekState>? listenWhen;
  final StateBuilderCondition<ScheduleWeekState>? buildWhen;
  final Widget? child;

  const ScheduleWeekStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ScheduleWeekState>(
    stateReadable: ScheduleScope.scheduleWeekSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ScheduleWeekStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ScheduleWeekState> builder;
  final StateBuilderCondition<ScheduleWeekState>? buildWhen;
  final Widget? child;

  const ScheduleWeekStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ScheduleWeekState>(
    stateReadable: ScheduleScope.scheduleWeekSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ScheduleWeekStateListener extends StatelessWidget {
  final StateWidgetListener<ScheduleWeekState> listener;
  final StateListenerCondition<ScheduleWeekState>? listenWhen;
  final Widget child;

  const ScheduleWeekStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ScheduleWeekState>(
    stateReadable: ScheduleScope.scheduleWeekSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ScheduleWeekStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ScheduleWeekState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ScheduleWeekStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ScheduleWeekState, T>(
    stateReadable: ScheduleScope.scheduleWeekSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
