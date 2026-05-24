import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/scope/video_content_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

/// Consumer widget for video content random state.
///
/// Listens to and rebuilds based on video content random state changes.
class VideoContentRandomStateConsumer extends StatelessWidget {
  final StateWidgetListener<VideoContentState> listener;
  final StateWidgetBuilder<VideoContentState> builder;
  final StateListenerCondition<VideoContentState>? listenWhen;
  final StateBuilderCondition<VideoContentState>? buildWhen;
  final Widget? child;

  const VideoContentRandomStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<VideoContentState>(
    stateReadable: VideoContentScope.videoContentRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

/// Builder widget for video content random state.
///
/// Rebuilds based on video content random state changes.
class VideoContentRandomStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<VideoContentState> builder;
  final StateBuilderCondition<VideoContentState>? buildWhen;
  final Widget? child;

  const VideoContentRandomStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<VideoContentState>(
    stateReadable: VideoContentScope.videoContentRandomSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

/// Listener widget for video content random state.
///
/// Listens to video content random state changes without rebuilding.
class VideoContentRandomStateListener extends StatelessWidget {
  final StateWidgetListener<VideoContentState> listener;
  final StateListenerCondition<VideoContentState>? listenWhen;
  final Widget child;

  const VideoContentRandomStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<VideoContentState>(
    stateReadable: VideoContentScope.videoContentRandomSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

/// Selector widget for video content random state.
///
/// Selects a specific part of the state and rebuilds only when that part changes.
class VideoContentRandomStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<VideoContentState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const VideoContentRandomStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<VideoContentState, T>(
    stateReadable: VideoContentScope.videoContentRandomSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
