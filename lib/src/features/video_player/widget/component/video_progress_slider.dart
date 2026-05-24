import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';

class VideoProgressSlider extends StatefulWidget {
  const VideoProgressSlider({super.key});

  @override
  State<VideoProgressSlider> createState() => _VideoProgressSliderState();
}

class _VideoProgressSliderState extends State<VideoProgressSlider> {
  bool _controllerWasPlaying = false;

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateBuilder(
    buildWhen: (prev, next) =>
        prev.position != next.position || prev.duration != next.duration,
    builder: (context, state, _) => Slider(
      value: _value(state.duration, state.position),
      onChangeStart: (_) => _onChangedStart(context),
      onChanged: (value) => _onChanged(context, value),
      onChangeEnd: (_) => _onChangeEnd(context),
      allowedInteraction: SliderInteraction.tapAndSlide,
    ),
  );

  double _value(Duration duration, Duration position) {
    final durationInMS = duration.inMilliseconds;
    final positionInMS = position.inMilliseconds;

    if (duration.inMilliseconds == 0) {
      return 0;
    }

    return positionInMS / durationInMS;
  }

  void _onChangedStart(BuildContext context) {
    final state = PlayerEpisodeScope.infoSMOf(
      context,
      listen: false,
    ).state;
    if (!state.isInitialized) {
      return;
    }

    final wm = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );

    _controllerWasPlaying = state.isPlaying;
    if (_controllerWasPlaying) {
      return wm.pause().ignore();
    }
  }

  void _onChanged(BuildContext context, double value) {
    final state = PlayerEpisodeScope.infoSMOf(
      context,
      listen: false,
    ).state;
    if (!state.isInitialized) {
      return;
    }

    final wm = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );

    final seekToMS = (state.duration.inMilliseconds * value).toInt();
    return wm.seekTo(Duration(milliseconds: seekToMS)).ignore();
  }

  void _onChangeEnd(BuildContext context) {
    final state = PlayerEpisodeScope.infoSMOf(
      context,
      listen: false,
    ).state;
    if (!state.isInitialized) {
      return;
    }

    final wm = PlayerEpisodeScope.controlWMOf(
      context,
      listen: false,
    );

    if (_controllerWasPlaying && state.position != state.duration) {
      return wm.play().ignore();
    }
  }
}
