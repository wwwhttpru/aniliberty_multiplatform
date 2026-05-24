import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class FranchisesRandomStateConsumer extends StatelessWidget {
  final StateWidgetListener<FranchisesState> listener;
  final StateWidgetBuilder<FranchisesState> builder;
  final StateListenerCondition<FranchisesState>? listenWhen;
  final StateBuilderCondition<FranchisesState>? buildWhen;
  final Widget? child;

  const FranchisesRandomStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<FranchisesState>(
    stateReadable: FranchisesScope.franchisesRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class FranchisesRandomStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<FranchisesState> builder;
  final StateBuilderCondition<FranchisesState>? buildWhen;
  final Widget? child;

  const FranchisesRandomStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<FranchisesState>(
    stateReadable: FranchisesScope.franchisesRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class FranchisesRandomStateListener extends StatelessWidget {
  final StateWidgetListener<FranchisesState> listener;
  final StateListenerCondition<FranchisesState>? listenWhen;
  final Widget child;

  const FranchisesRandomStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<FranchisesState>(
    stateReadable: FranchisesScope.franchisesRandomSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class FranchisesRandomStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<FranchisesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const FranchisesRandomStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<FranchisesState, T>(
    stateReadable: FranchisesScope.franchisesRandomSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
