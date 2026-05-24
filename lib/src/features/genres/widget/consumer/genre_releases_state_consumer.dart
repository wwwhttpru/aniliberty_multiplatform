import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class GenreReleasesStateConsumer extends StatelessWidget {
  final StateWidgetListener<GenreReleasesState> listener;
  final StateWidgetBuilder<GenreReleasesState> builder;
  final StateListenerCondition<GenreReleasesState>? listenWhen;
  final StateBuilderCondition<GenreReleasesState>? buildWhen;
  final Widget? child;

  const GenreReleasesStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<GenreReleasesState>(
    stateReadable: GenreReleasesScope.genreReleasesSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class GenreReleasesStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<GenreReleasesState> builder;
  final StateBuilderCondition<GenreReleasesState>? buildWhen;
  final Widget? child;

  const GenreReleasesStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<GenreReleasesState>(
    stateReadable: GenreReleasesScope.genreReleasesSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class GenreReleasesStateListener extends StatelessWidget {
  final StateWidgetListener<GenreReleasesState> listener;
  final StateListenerCondition<GenreReleasesState>? listenWhen;
  final Widget child;

  const GenreReleasesStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<GenreReleasesState>(
    stateReadable: GenreReleasesScope.genreReleasesSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class GenreReleasesStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<GenreReleasesState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const GenreReleasesStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<GenreReleasesState, T>(
    stateReadable: GenreReleasesScope.genreReleasesSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
