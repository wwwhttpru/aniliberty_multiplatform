import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/scope/video_content_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

/// Consumer widget for video content all state.
///
/// Listens to and rebuilds based on video content all state changes.
class VideoContentAllStateConsumer extends StatelessWidget {
  final StateWidgetListener<VideoContentState> listener;
  final StateWidgetBuilder<VideoContentState> builder;
  final StateListenerCondition<VideoContentState>? listenWhen;
  final StateBuilderCondition<VideoContentState>? buildWhen;
  final Widget? child;

  const VideoContentAllStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<VideoContentState>(
    stateReadable: VideoContentScope.videoContentAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

/// Builder widget for video content all state.
///
/// Rebuilds based on video content all state changes.
class VideoContentAllStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<VideoContentState> builder;
  final StateBuilderCondition<VideoContentState>? buildWhen;
  final Widget? child;

  const VideoContentAllStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<VideoContentState>(
    stateReadable: VideoContentScope.videoContentAllSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

/// Listener widget for video content all state.
///
/// Listens to video content all state changes without rebuilding.
class VideoContentAllStateListener extends StatelessWidget {
  final StateWidgetListener<VideoContentState> listener;
  final StateListenerCondition<VideoContentState>? listenWhen;
  final Widget child;

  const VideoContentAllStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<VideoContentState>(
    stateReadable: VideoContentScope.videoContentAllSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

/// Selector widget for video content all state.
///
/// Selects a specific part of the state and rebuilds only when that part changes.
class VideoContentAllStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<VideoContentState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const VideoContentAllStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<VideoContentState, T>(
    stateReadable: VideoContentScope.videoContentAllSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
