import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class VideoPlayerControllerConsumer extends StatelessWidget {
  final StateWidgetListener<VideoPlayerControllerState> listener;
  final StateWidgetBuilder<VideoPlayerControllerState> builder;
  final StateListenerCondition<VideoPlayerControllerState>? listenWhen;
  final StateBuilderCondition<VideoPlayerControllerState>? buildWhen;
  final Widget? child;

  const VideoPlayerControllerConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateConsumer<VideoPlayerControllerState>(
        stateReadable: PlayerEpisodeScope.controllerSMOf(context),
        builder: builder,
        buildWhen: buildWhen,
        child: child,
        listener: listener,
        listenWhen: listenWhen,
      );
}

class VideoPlayerControllerBuilder extends StatelessWidget {
  final StateWidgetBuilder<VideoPlayerControllerState> builder;
  final StateBuilderCondition<VideoPlayerControllerState>? buildWhen;
  final Widget? child;

  const VideoPlayerControllerBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateBuilder<VideoPlayerControllerState>(
        stateReadable: PlayerEpisodeScope.controllerSMOf(context),
        builder: builder,
        buildWhen: buildWhen,
        child: child,
      );
}

class VideoPlayerControllerListener extends StatelessWidget {
  final StateWidgetListener<VideoPlayerControllerState> listener;
  final StateListenerCondition<VideoPlayerControllerState>? listenWhen;
  final Widget child;

  const VideoPlayerControllerListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateListener<VideoPlayerControllerState>(
        stateReadable: PlayerEpisodeScope.controllerSMOf(context),
        listener: listener,
        listenWhen: listenWhen,
        child: child,
      );
}

class VideoPlayerControllerSelector<T> extends StatelessWidget {
  final StateWidgetSelector<VideoPlayerControllerState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const VideoPlayerControllerSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateSelector<VideoPlayerControllerState, T>(
        stateReadable: PlayerEpisodeScope.controllerSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
