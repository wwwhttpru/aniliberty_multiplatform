import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ReleasesLatestAllStateConsumer extends StatelessWidget {
  final StateWidgetListener<ReleasesState> listener;
  final StateWidgetBuilder<ReleasesState> builder;
  final StateListenerCondition<ReleasesState>? listenWhen;
  final StateBuilderCondition<ReleasesState>? buildWhen;
  final Widget? child;

  const ReleasesLatestAllStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ReleasesLatestAllStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ReleasesState> builder;
  final StateBuilderCondition<ReleasesState>? buildWhen;
  final Widget? child;

  const ReleasesLatestAllStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ReleasesLatestAllStateListener extends StatelessWidget {
  final StateWidgetListener<ReleasesState> listener;
  final StateListenerCondition<ReleasesState>? listenWhen;
  final Widget child;

  const ReleasesLatestAllStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestAllSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ReleasesLatestAllStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ReleasesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ReleasesLatestAllStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ReleasesState, T>(
    stateReadable: ReleasesScope.releasesLatestAllSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
