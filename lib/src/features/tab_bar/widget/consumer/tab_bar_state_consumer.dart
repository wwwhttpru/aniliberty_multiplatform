import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/scope/tab_bar_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class TabBarStateConsumer extends StatelessWidget {
  final StateWidgetListener<TabBarState> listener;
  final StateWidgetBuilder<TabBarState> builder;
  final StateListenerCondition<TabBarState>? listenWhen;
  final StateBuilderCondition<TabBarState>? buildWhen;
  final Widget? child;

  const TabBarStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<TabBarState>(
    stateReadable: TabBarScope.tabBarSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class TabBarStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<TabBarState> builder;
  final StateBuilderCondition<TabBarState>? buildWhen;
  final Widget? child;

  const TabBarStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<TabBarState>(
    stateReadable: TabBarScope.tabBarSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class TabBarStateListener extends StatelessWidget {
  final StateWidgetListener<TabBarState> listener;
  final StateListenerCondition<TabBarState>? listenWhen;
  final Widget child;

  const TabBarStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<TabBarState>(
    stateReadable: TabBarScope.tabBarSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class TabBarStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<TabBarState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const TabBarStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<TabBarState, T>(
    stateReadable: TabBarScope.tabBarSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
