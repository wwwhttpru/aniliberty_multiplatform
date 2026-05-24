import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Route configuration for video player screens.
///
/// Provides route definitions and utilities for navigating to video player
/// and settings screens with episode identifiers.
@immutable
class VideoPlayerRoute {
  /// Video player screen ID
  YxRoute get video => const YxRoute(id: 'video');

  /// Settings screen ID
  YxRoute get settings => const YxRoute(id: 'settings');

  /// Id for getting episode ID from route arguments
  String get episodeId => 'episode_id';

  const VideoPlayerRoute();

  /// Get episode ID from route arguments
  String? getEpisodeIDFromMap(Map<String, String> value) {
    final episodeId = value[this.episodeId];
    return episodeId;
  }
}
