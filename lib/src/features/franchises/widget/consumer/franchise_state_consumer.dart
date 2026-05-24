import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class FranchiseStateConsumer extends StatelessWidget {
  final StateWidgetListener<FranchiseState> listener;
  final StateWidgetBuilder<FranchiseState> builder;
  final StateListenerCondition<FranchiseState>? listenWhen;
  final StateBuilderCondition<FranchiseState>? buildWhen;
  final Widget? child;

  const FranchiseStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<FranchiseState>(
    stateReadable: FranchiseScope.franchiseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class FranchiseStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<FranchiseState> builder;
  final StateBuilderCondition<FranchiseState>? buildWhen;
  final Widget? child;

  const FranchiseStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<FranchiseState>(
    stateReadable: FranchiseScope.franchiseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class FranchiseStateListener extends StatelessWidget {
  final StateWidgetListener<FranchiseState> listener;
  final StateListenerCondition<FranchiseState>? listenWhen;
  final Widget child;

  const FranchiseStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<FranchiseState>(
    stateReadable: FranchiseScope.franchiseSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class FranchiseStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<FranchiseState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const FranchiseStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<FranchiseState, T>(
    stateReadable: FranchiseScope.franchiseSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
