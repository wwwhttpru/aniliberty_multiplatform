import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/scope/app_status_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

/// Consumer widget for app status state
class AppStatusStateConsumer extends StatelessWidget {
  /// Listener for state changes
  final StateWidgetListener<AppStatusState> listener;

  /// Builder for building widgets based on state
  final StateWidgetBuilder<AppStatusState> builder;

  /// Condition for when to listen to state changes
  final StateListenerCondition<AppStatusState>? listenWhen;

  /// Condition for when to rebuild
  final StateBuilderCondition<AppStatusState>? buildWhen;

  /// Optional child widget
  final Widget? child;

  const AppStatusStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<AppStatusState>(
    stateReadable: AppStatusScope.appStatusSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

/// Builder widget for app status state
class AppStatusStateBuilder extends StatelessWidget {
  /// Builder for building widgets based on state
  final StateWidgetBuilder<AppStatusState> builder;

  /// Condition for when to rebuild
  final StateBuilderCondition<AppStatusState>? buildWhen;

  /// Optional child widget
  final Widget? child;

  const AppStatusStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<AppStatusState>(
    stateReadable: AppStatusScope.appStatusSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

/// Listener widget for app status state
class AppStatusStateListener extends StatelessWidget {
  /// Listener for state changes
  final StateWidgetListener<AppStatusState> listener;

  /// Condition for when to listen to state changes
  final StateListenerCondition<AppStatusState>? listenWhen;

  /// Child widget
  final Widget child;

  const AppStatusStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<AppStatusState>(
    stateReadable: AppStatusScope.appStatusSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

/// Selector widget for app status state
class AppStatusStateSelector<T> extends StatelessWidget {
  /// Selector function to extract value from state
  final StateWidgetSelector<AppStatusState, T> selector;

  /// Builder for building widgets based on selected value
  final StateWidgetBuilder<T> builder;

  /// Optional child widget
  final Widget? child;

  const AppStatusStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<AppStatusState, T>(
    stateReadable: AppStatusScope.appStatusSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
