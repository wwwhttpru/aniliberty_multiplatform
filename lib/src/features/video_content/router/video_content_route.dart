import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template video_content_route}
/// Route configuration for video content screens.
///
/// Provides route definitions and utilities for navigating to video content screens.
/// {@endtemplate}
@immutable
class VideoContentRoute {
  /// Route for the video content screen.
  ///
  /// Returns a [YxRoute] with id 'video-content' for navigating
  /// to the video content screen.
  YxRoute get videoContent => const YxRoute(id: 'video-content');

  /// {@macro video_content_route}
  const VideoContentRoute();
}
