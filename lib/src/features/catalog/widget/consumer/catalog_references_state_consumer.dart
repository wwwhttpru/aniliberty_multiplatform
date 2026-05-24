import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class CatalogReferencesStateConsumer extends StatelessWidget {
  final StateWidgetListener<CatalogReferencesState> listener;
  final StateWidgetBuilder<CatalogReferencesState> builder;
  final StateListenerCondition<CatalogReferencesState>? listenWhen;
  final StateBuilderCondition<CatalogReferencesState>? buildWhen;
  final Widget? child;

  const CatalogReferencesStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<CatalogReferencesState>(
    stateReadable: CatalogScope.catalogReferencesSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class CatalogReferencesStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<CatalogReferencesState> builder;
  final StateBuilderCondition<CatalogReferencesState>? buildWhen;
  final Widget? child;

  const CatalogReferencesStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<CatalogReferencesState>(
    stateReadable: CatalogScope.catalogReferencesSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class CatalogReferencesStateListener extends StatelessWidget {
  final StateWidgetListener<CatalogReferencesState> listener;
  final StateListenerCondition<CatalogReferencesState>? listenWhen;
  final Widget child;

  const CatalogReferencesStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<CatalogReferencesState>(
    stateReadable: CatalogScope.catalogReferencesSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class CatalogReferencesStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<CatalogReferencesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const CatalogReferencesStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateSelector<CatalogReferencesState, T>(
        stateReadable: CatalogScope.catalogReferencesSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
