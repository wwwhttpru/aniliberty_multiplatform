import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/scope/promotions_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class PromotionsStateConsumer extends StatelessWidget {
  final StateWidgetListener<PromotionsState> listener;
  final StateWidgetBuilder<PromotionsState> builder;
  final StateListenerCondition<PromotionsState>? listenWhen;
  final StateBuilderCondition<PromotionsState>? buildWhen;
  final Widget? child;

  const PromotionsStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<PromotionsState>(
    stateReadable: PromotionsScope.promotionsSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class PromotionsStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<PromotionsState> builder;
  final StateBuilderCondition<PromotionsState>? buildWhen;
  final Widget? child;

  const PromotionsStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<PromotionsState>(
    stateReadable: PromotionsScope.promotionsSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class PromotionsStateListener extends StatelessWidget {
  final StateWidgetListener<PromotionsState> listener;
  final StateListenerCondition<PromotionsState>? listenWhen;
  final Widget child;

  const PromotionsStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<PromotionsState>(
    stateReadable: PromotionsScope.promotionsSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class PromotionsStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<PromotionsState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const PromotionsStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<PromotionsState, T>(
    stateReadable: PromotionsScope.promotionsSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
