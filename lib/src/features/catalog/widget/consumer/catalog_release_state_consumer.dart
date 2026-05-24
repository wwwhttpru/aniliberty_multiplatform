import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class CatalogReleaseStateConsumer extends StatelessWidget {
  final StateWidgetListener<CatalogReleaseState> listener;
  final StateWidgetBuilder<CatalogReleaseState> builder;
  final StateListenerCondition<CatalogReleaseState>? listenWhen;
  final StateBuilderCondition<CatalogReleaseState>? buildWhen;
  final Widget? child;

  const CatalogReleaseStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<CatalogReleaseState>(
    stateReadable: CatalogScope.catalogReleaseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class CatalogReleaseStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<CatalogReleaseState> builder;
  final StateBuilderCondition<CatalogReleaseState>? buildWhen;
  final Widget? child;

  const CatalogReleaseStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<CatalogReleaseState>(
    stateReadable: CatalogScope.catalogReleaseSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class CatalogReleaseStateListener extends StatelessWidget {
  final StateWidgetListener<CatalogReleaseState> listener;
  final StateListenerCondition<CatalogReleaseState>? listenWhen;
  final Widget child;

  const CatalogReleaseStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<CatalogReleaseState>(
    stateReadable: CatalogScope.catalogReleaseSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class CatalogReleaseStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<CatalogReleaseState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const CatalogReleaseStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<CatalogReleaseState, T>(
    stateReadable: CatalogScope.catalogReleaseSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
