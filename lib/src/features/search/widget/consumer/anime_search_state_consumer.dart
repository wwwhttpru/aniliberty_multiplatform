import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/scope/search_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class AnimeSearchStateConsumer extends StatelessWidget {
  final StateWidgetListener<AnimeSearchState> listener;
  final StateWidgetBuilder<AnimeSearchState> builder;
  final StateListenerCondition<AnimeSearchState>? listenWhen;
  final StateBuilderCondition<AnimeSearchState>? buildWhen;
  final Widget? child;

  const AnimeSearchStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<AnimeSearchState>(
    stateReadable: SearchScope.animeSearchSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class AnimeSearchStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<AnimeSearchState> builder;
  final StateBuilderCondition<AnimeSearchState>? buildWhen;
  final Widget? child;

  const AnimeSearchStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<AnimeSearchState>(
    stateReadable: SearchScope.animeSearchSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class AnimeSearchStateListener extends StatelessWidget {
  final StateWidgetListener<AnimeSearchState> listener;
  final StateListenerCondition<AnimeSearchState>? listenWhen;
  final Widget child;

  const AnimeSearchStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<AnimeSearchState>(
    stateReadable: SearchScope.animeSearchSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class AnimeSearchStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<AnimeSearchState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const AnimeSearchStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<AnimeSearchState, T>(
    stateReadable: SearchScope.animeSearchSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
