import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class VideoQualityStateConsumer extends StatelessWidget {
  final StateWidgetListener<VideoQualityState> listener;
  final StateWidgetBuilder<VideoQualityState> builder;
  final StateListenerCondition<VideoQualityState>? listenWhen;
  final StateBuilderCondition<VideoQualityState>? buildWhen;
  final Widget? child;

  const VideoQualityStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<VideoQualityState>(
    stateReadable: PlayerEpisodeScope.videoQualitySMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class VideoQualityStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<VideoQualityState> builder;
  final StateBuilderCondition<VideoQualityState>? buildWhen;
  final Widget? child;

  const VideoQualityStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<VideoQualityState>(
    stateReadable: PlayerEpisodeScope.videoQualitySMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class VideoQualityStateListener extends StatelessWidget {
  final StateWidgetListener<VideoQualityState> listener;
  final StateListenerCondition<VideoQualityState>? listenWhen;
  final Widget child;

  const VideoQualityStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<VideoQualityState>(
    stateReadable: PlayerEpisodeScope.videoQualitySMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class VideoQualityStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<VideoQualityState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const VideoQualityStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<VideoQualityState, T>(
    stateReadable: PlayerEpisodeScope.videoQualitySMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
