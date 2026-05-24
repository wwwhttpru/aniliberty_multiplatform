import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ScheduleNowStateConsumer extends StatelessWidget {
  final StateWidgetListener<ScheduleNowState> listener;
  final StateWidgetBuilder<ScheduleNowState> builder;
  final StateListenerCondition<ScheduleNowState>? listenWhen;
  final StateBuilderCondition<ScheduleNowState>? buildWhen;
  final Widget? child;

  const ScheduleNowStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ScheduleNowState>(
    stateReadable: ScheduleScope.scheduleNowSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ScheduleNowStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ScheduleNowState> builder;
  final StateBuilderCondition<ScheduleNowState>? buildWhen;
  final Widget? child;

  const ScheduleNowStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ScheduleNowState>(
    stateReadable: ScheduleScope.scheduleNowSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ScheduleNowStateListener extends StatelessWidget {
  final StateWidgetListener<ScheduleNowState> listener;
  final StateListenerCondition<ScheduleNowState>? listenWhen;
  final Widget child;

  const ScheduleNowStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ScheduleNowState>(
    stateReadable: ScheduleScope.scheduleNowSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ScheduleNowStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ScheduleNowState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ScheduleNowStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ScheduleNowState, T>(
    stateReadable: ScheduleScope.scheduleNowSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
