import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class GenresRandomStateConsumer extends StatelessWidget {
  final StateWidgetListener<GenresState> listener;
  final StateWidgetBuilder<GenresState> builder;
  final StateListenerCondition<GenresState>? listenWhen;
  final StateBuilderCondition<GenresState>? buildWhen;
  final Widget? child;

  const GenresRandomStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<GenresState>(
    stateReadable: GenresScope.genresRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class GenresRandomStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<GenresState> builder;
  final StateBuilderCondition<GenresState>? buildWhen;
  final Widget? child;

  const GenresRandomStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<GenresState>(
    stateReadable: GenresScope.genresRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class GenresRandomStateListener extends StatelessWidget {
  final StateWidgetListener<GenresState> listener;
  final StateListenerCondition<GenresState>? listenWhen;
  final Widget child;

  const GenresRandomStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<GenresState>(
    stateReadable: GenresScope.genresRandomSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class GenresRandomStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<GenresState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const GenresRandomStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<GenresState, T>(
    stateReadable: GenresScope.genresRandomSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
