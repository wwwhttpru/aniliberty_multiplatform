// ignore_for_file: avoid_positional_boolean_parameters
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';

typedef FullScreenState = ({bool isFullscreen, bool isFullscreenSupported});

/// Consumer for tracking fullscreen mode changes
class FullScreenStateBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, FullScreenState state) builder;

  const FullScreenStateBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final service = PlayerEpisodeScope.fullScreenServiceOf(context);
    return StreamBuilder<bool>(
      stream: service.fullscreenSupportedStream,
      initialData: service.isFullscreenSupported,
      builder: (context, supportedSnapshot) => StreamBuilder<bool>(
        stream: service.fullscreenStream,
        initialData: service.isFullscreen,
        builder: (context, fullscreenSnapshot) => builder(
          context,
          (
            isFullscreen: fullscreenSnapshot.data ?? false,
            isFullscreenSupported: supportedSnapshot.data ?? false,
          ),
        ),
      ),
    );
  }
}
