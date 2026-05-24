import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state/yx_state.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

/// Consumer for setting value state
class SettingValueStateConsumer<T> extends StatelessWidget {
  final StateReadable<SettingValueState<T>> stateReadable;
  final StateWidgetListener<SettingValueState<T>> listener;
  final StateWidgetBuilder<SettingValueState<T>> builder;
  final StateListenerCondition<SettingValueState<T>>? listenWhen;
  final StateBuilderCondition<SettingValueState<T>>? buildWhen;
  final Widget? child;

  const SettingValueStateConsumer({
    required this.stateReadable,
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<SettingValueState<T>>(
    stateReadable: stateReadable,
    builder: builder,
    buildWhen: buildWhen,
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

/// Builder for setting value state
class SettingValueStateBuilder<T> extends StatelessWidget {
  final StateReadable<SettingValueState<T>> stateReadable;
  final StateWidgetBuilder<SettingValueState<T>> builder;
  final StateBuilderCondition<SettingValueState<T>>? buildWhen;
  final Widget? child;

  const SettingValueStateBuilder({
    required this.stateReadable,
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<SettingValueState<T>>(
    stateReadable: stateReadable,
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

/// Listener for setting value state
class SettingValueStateListener<T> extends StatelessWidget {
  final StateReadable<SettingValueState<T>> stateReadable;
  final StateWidgetListener<SettingValueState<T>> listener;
  final StateListenerCondition<SettingValueState<T>>? listenWhen;
  final Widget child;

  const SettingValueStateListener({
    required this.stateReadable,
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<SettingValueState<T>>(
    stateReadable: stateReadable,
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

/// Selector for setting value state
class SettingValueStateSelector<T, R> extends StatelessWidget {
  final StateReadable<SettingValueState<T>> stateReadable;
  final StateWidgetSelector<SettingValueState<T>, R> selector;
  final StateWidgetBuilder<R> builder;
  final Widget? child;

  const SettingValueStateSelector({
    required this.stateReadable,
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<SettingValueState<T>, R>(
    stateReadable: stateReadable,
    selector: selector,
    builder: builder,
    child: child,
  );
}
