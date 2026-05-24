import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ReleaseStateConsumer extends StatelessWidget {
  final StateWidgetListener<ReleaseState> listener;
  final StateWidgetBuilder<ReleaseState> builder;
  final StateListenerCondition<ReleaseState>? listenWhen;
  final StateBuilderCondition<ReleaseState>? buildWhen;
  final Widget? child;

  const ReleaseStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ReleaseState>(
    stateReadable: ReleaseScope.releaseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ReleaseStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ReleaseState> builder;
  final StateBuilderCondition<ReleaseState>? buildWhen;
  final Widget? child;

  const ReleaseStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ReleaseState>(
    stateReadable: ReleaseScope.releaseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ReleaseStateListener extends StatelessWidget {
  final StateWidgetListener<ReleaseState> listener;
  final StateListenerCondition<ReleaseState>? listenWhen;
  final Widget child;

  const ReleaseStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ReleaseState>(
    stateReadable: ReleaseScope.releaseSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ReleaseStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ReleaseState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ReleaseStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ReleaseState, T>(
    stateReadable: ReleaseScope.releaseSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
