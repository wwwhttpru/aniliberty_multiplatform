import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A video player widget that adapts to available space while maintaining aspect ratio.
///
/// This widget handles platform-specific issues, particularly on Safari web where
/// the video aspect ratio cannot be correctly determined. It uses [VideoAspectRatioUtils]
/// to get a safe aspect ratio value that works across all platforms.
///
/// The widget calculates optimal video dimensions based on available constraints
/// and ensures the video is properly sized and centered within its container.
class AdaptedVideoPlayer extends StatelessWidget {
  /// The video player controller that manages video playback.
  final VideoPlayerController controller;

  const AdaptedVideoPlayer({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) => VideoPlayerInfoStateSelector<double>(
    selector: (state) => VideoAspectRatioUtils.getSafeAspectRatio(
      state.aspectRatio,
    ),
    builder: (context, aspectRatio, child) => LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // Calculate optimal video size that fits within available space
        // while maintaining the aspect ratio
        final videoSize = _calculateOptimalVideoSize(
          availableWidth: availableWidth,
          availableHeight: availableHeight,
          aspectRatio: aspectRatio,
        );

        return Center(
          child: SizedBox.fromSize(
            size: videoSize,
            child: AspectRatio(aspectRatio: aspectRatio, child: child),
          ),
        );
      },
    ),
    child: VideoPlayer(controller),
  );

  /// Calculates the optimal video size that fits within available space.
  ///
  /// The algorithm:
  /// 1. Starts with full available width and calculates height based on aspect ratio
  /// 2. If the calculated height exceeds available height, scales down based on height
  /// 3. Ensures the final width doesn't exceed available width (for very wide videos)
  ///
  /// Returns a [Size] that fits within [availableWidth] x [availableHeight]
  /// while maintaining the [aspectRatio].
  Size _calculateOptimalVideoSize({
    required double availableWidth,
    required double availableHeight,
    required double aspectRatio,
  }) {
    // Start with full width
    var videoWidth = availableWidth;
    var videoHeight = availableWidth / aspectRatio;

    // If video doesn't fit by height, scale down based on height
    if (videoHeight > availableHeight) {
      videoHeight = availableHeight;
      videoWidth = availableHeight * aspectRatio;
    }

    // Additional check for very wide videos
    if (videoWidth > availableWidth) {
      videoWidth = availableWidth;
      videoHeight = availableWidth / aspectRatio;
    }

    return Size(videoWidth, videoHeight);
  }
}
