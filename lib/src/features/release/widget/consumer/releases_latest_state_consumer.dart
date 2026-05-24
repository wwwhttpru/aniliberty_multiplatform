import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ReleasesLatestStateConsumer extends StatelessWidget {
  final StateWidgetListener<ReleasesState> listener;
  final StateWidgetBuilder<ReleasesState> builder;
  final StateListenerCondition<ReleasesState>? listenWhen;
  final StateBuilderCondition<ReleasesState>? buildWhen;
  final Widget? child;

  const ReleasesLatestStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ReleasesLatestStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ReleasesState> builder;
  final StateBuilderCondition<ReleasesState>? buildWhen;
  final Widget? child;

  const ReleasesLatestStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ReleasesLatestStateListener extends StatelessWidget {
  final StateWidgetListener<ReleasesState> listener;
  final StateListenerCondition<ReleasesState>? listenWhen;
  final Widget child;

  const ReleasesLatestStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ReleasesState>(
    stateReadable: ReleasesScope.releasesLatestSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ReleasesLatestStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ReleasesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ReleasesLatestStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ReleasesState, T>(
    stateReadable: ReleasesScope.releasesLatestSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
