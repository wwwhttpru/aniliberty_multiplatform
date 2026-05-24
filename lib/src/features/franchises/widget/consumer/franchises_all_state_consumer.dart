import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class FranchisesAllStateConsumer extends StatelessWidget {
  final StateWidgetListener<FranchisesState> listener;
  final StateWidgetBuilder<FranchisesState> builder;
  final StateListenerCondition<FranchisesState>? listenWhen;
  final StateBuilderCondition<FranchisesState>? buildWhen;
  final Widget? child;

  const FranchisesAllStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<FranchisesState>(
    stateReadable: FranchisesScope.franchisesAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class FranchisesAllStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<FranchisesState> builder;
  final StateBuilderCondition<FranchisesState>? buildWhen;
  final Widget? child;

  const FranchisesAllStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<FranchisesState>(
    stateReadable: FranchisesScope.franchisesAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class FranchisesAllStateListener extends StatelessWidget {
  final StateWidgetListener<FranchisesState> listener;
  final StateListenerCondition<FranchisesState>? listenWhen;
  final Widget child;

  const FranchisesAllStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<FranchisesState>(
    stateReadable: FranchisesScope.franchisesAllSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class FranchisesAllStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<FranchisesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const FranchisesAllStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<FranchisesState, T>(
    stateReadable: FranchisesScope.franchisesAllSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
