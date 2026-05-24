import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class GenresStateConsumer extends StatelessWidget {
  final StateWidgetListener<GenresState> listener;
  final StateWidgetBuilder<GenresState> builder;
  final StateListenerCondition<GenresState>? listenWhen;
  final StateBuilderCondition<GenresState>? buildWhen;
  final Widget? child;

  const GenresStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<GenresState>(
    stateReadable: GenresScope.genresSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class GenresStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<GenresState> builder;
  final StateBuilderCondition<GenresState>? buildWhen;
  final Widget? child;

  const GenresStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<GenresState>(
    stateReadable: GenresScope.genresSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class GenresStateListener extends StatelessWidget {
  final StateWidgetListener<GenresState> listener;
  final StateListenerCondition<GenresState>? listenWhen;
  final Widget child;

  const GenresStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<GenresState>(
    stateReadable: GenresScope.genresSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class GenresStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<GenresState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const GenresStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<GenresState, T>(
    stateReadable: GenresScope.genresSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
