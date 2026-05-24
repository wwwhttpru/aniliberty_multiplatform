import 'package:aniliberty_multiplatform/src/features/video_player/router/video_player_route.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Guard for video player route.
///
/// Checks if the target route is part of the video player route.
/// it is, checks if the episode ID is valid. If it is not, the navigation is canceled.
/// If it is, the navigation is continued.
class VideoPlayerGuard implements RouteNodeGuard {
  final VideoPlayerRoute _route;

  const VideoPlayerGuard({
    required this._route,
  });

  @override
  GuardResult call(
    RouteNode origin,
    RouteNode target,
    GuardContext context,
  ) {
    final brokenNodes = <RouteNode>[];

    // Finds all nodes that are part of the video player route
    target.traverse(
      (routeNode) {
        final episodeId = _route.getEpisodeIDFromMap(
          routeNode.arguments,
        );

        // If episode ID is not found, add to broken nodes and return false
        if (episodeId == null) {
          brokenNodes.add(routeNode);
          return true;
        }

        return false;
      },
      predicate: (routeNode) => routeNode.route.id == _route.video.id,
    );

    // If there are broken nodes, cancel the navigation
    if (brokenNodes.isNotEmpty) {
      return const GuardResult.cancel();
    }

    // If there are no broken nodes, continue the navigation
    return const GuardResult.next();
  }
}
