import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class VideoPlayerInfoStateConsumer extends StatelessWidget {
  final StateWidgetListener<VideoPlayerState> listener;
  final StateWidgetBuilder<VideoPlayerState> builder;
  final StateListenerCondition<VideoPlayerState>? listenWhen;
  final StateBuilderCondition<VideoPlayerState>? buildWhen;
  final Widget? child;

  const VideoPlayerInfoStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<VideoPlayerState>(
    stateReadable: PlayerEpisodeScope.infoSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class VideoPlayerInfoStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<VideoPlayerState> builder;
  final StateBuilderCondition<VideoPlayerState>? buildWhen;
  final Widget? child;

  const VideoPlayerInfoStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<VideoPlayerState>(
    stateReadable: PlayerEpisodeScope.infoSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class VideoPlayerInfoStateListener extends StatelessWidget {
  final StateWidgetListener<VideoPlayerState> listener;
  final StateListenerCondition<VideoPlayerState>? listenWhen;
  final Widget child;

  const VideoPlayerInfoStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<VideoPlayerState>(
    stateReadable: PlayerEpisodeScope.infoSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class VideoPlayerInfoStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<VideoPlayerState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const VideoPlayerInfoStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<VideoPlayerState, T>(
    stateReadable: PlayerEpisodeScope.infoSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
