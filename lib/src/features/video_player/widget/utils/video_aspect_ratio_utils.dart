import 'package:flutter/foundation.dart';

/// Utilities for working with video player aspect ratio.
class VideoAspectRatioUtils {
  const VideoAspectRatioUtils._();

  /// Standard aspect ratios for video content.
  static const double standardAspectRatio = 16 / 9; // 1.777...
  static const double wideAspectRatio = 21 / 9; // 2.333...
  static const double classicAspectRatio = 4 / 3; // 1.333...
  static const double verticalAspectRatio = 9 / 16; // 0.5625...

  /// Minimum and maximum aspect ratio bounds.
  static const double minAspectRatio = 0.5; // Very vertical video
  static const double maxAspectRatio = 3; // Very wide video

  /// Gets a safe aspect ratio value considering platform-specific issues.
  ///
  /// On Safari web platform, the aspect ratio is always reported as 1.0 due to a bug
  /// in the video_player_web_hls package. This method provides a workaround by using
  /// the standard aspect ratio (16/9) as a fallback when aspect ratio equals 1.0 on web.
  ///
  /// See: https://github.com/balvinderz/video_player_web_hls/issues/58
  ///
  /// Returns [standardAspectRatio] if:
  /// - [aspectRatio] is invalid (<= 0, infinite, or NaN)
  /// - [aspectRatio] equals 1.0 on web platform (Safari workaround)
  ///
  /// Otherwise, returns the clamped aspect ratio within [minAspectRatio] and [maxAspectRatio].
  static double getSafeAspectRatio(double aspectRatio) {
    // Check for invalid values
    if (aspectRatio <= 0 || aspectRatio.isInfinite || aspectRatio.isNaN) {
      return standardAspectRatio;
    }

    // Safari web workaround: aspect ratio is always 1.0 due to a bug
    // Use standard aspect ratio as fallback
    if (kIsWeb && aspectRatio == 1.0) {
      return standardAspectRatio;
    }

    // Clamp extreme values to reasonable bounds
    return _clampAspectRatio(aspectRatio);
  }

  /// Clamps aspect ratio to reasonable bounds.
  ///
  /// Returns [minAspectRatio] if [aspectRatio] is less than [minAspectRatio],
  /// [maxAspectRatio] if [aspectRatio] is greater than [maxAspectRatio],
  /// otherwise returns [aspectRatio] unchanged.
  static double _clampAspectRatio(double aspectRatio) {
    if (aspectRatio < minAspectRatio) {
      return minAspectRatio;
    }

    if (aspectRatio > maxAspectRatio) {
      return maxAspectRatio;
    }

    return aspectRatio;
  }
}
