import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class TitleEpisodeStateConsumer extends StatelessWidget {
  final StateWidgetListener<TitleEpisodeState> listener;
  final StateWidgetBuilder<TitleEpisodeState> builder;
  final StateListenerCondition<TitleEpisodeState>? listenWhen;
  final StateBuilderCondition<TitleEpisodeState>? buildWhen;
  final Widget? child;

  const TitleEpisodeStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<TitleEpisodeState>(
    stateReadable: PlayerEpisodeScope.titleEpisodeSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class TitleEpisodeStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<TitleEpisodeState> builder;
  final StateBuilderCondition<TitleEpisodeState>? buildWhen;
  final Widget? child;

  const TitleEpisodeStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<TitleEpisodeState>(
    stateReadable: PlayerEpisodeScope.titleEpisodeSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class TitleEpisodeStateListener extends StatelessWidget {
  final StateWidgetListener<TitleEpisodeState> listener;
  final StateListenerCondition<TitleEpisodeState>? listenWhen;
  final Widget child;

  const TitleEpisodeStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<TitleEpisodeState>(
    stateReadable: PlayerEpisodeScope.titleEpisodeSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class TitleEpisodeStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<TitleEpisodeState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const TitleEpisodeStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<TitleEpisodeState, T>(
    stateReadable: PlayerEpisodeScope.titleEpisodeSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
