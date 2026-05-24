import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class CatalogFilterStateConsumer extends StatelessWidget {
  final StateWidgetListener<CatalogFilterState> listener;
  final StateWidgetBuilder<CatalogFilterState> builder;
  final StateListenerCondition<CatalogFilterState>? listenWhen;
  final StateBuilderCondition<CatalogFilterState>? buildWhen;
  final Widget? child;

  const CatalogFilterStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<CatalogFilterState>(
    stateReadable: CatalogScope.catalogFilterSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class CatalogFilterStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<CatalogFilterState> builder;
  final StateBuilderCondition<CatalogFilterState>? buildWhen;
  final Widget? child;

  const CatalogFilterStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<CatalogFilterState>(
    stateReadable: CatalogScope.catalogFilterSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class CatalogFilterStateListener extends StatelessWidget {
  final StateWidgetListener<CatalogFilterState> listener;
  final StateListenerCondition<CatalogFilterState>? listenWhen;
  final Widget child;

  const CatalogFilterStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<CatalogFilterState>(
    stateReadable: CatalogScope.catalogFilterSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class CatalogFilterStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<CatalogFilterState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const CatalogFilterStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<CatalogFilterState, T>(
    stateReadable: CatalogScope.catalogFilterSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
