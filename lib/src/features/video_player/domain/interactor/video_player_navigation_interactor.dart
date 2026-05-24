import 'package:aniliberty_multiplatform/src/features/video_player/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Interface for video player navigation operations.
///
/// Provides methods to open and close the video player screen
/// for a specific episode.
abstract interface class IVideoPlayerNavigationInteractor {
  /// Opens the video player screen for the specified episode.
  ///
  /// If a video player route already exists for this episode, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  ///
  /// [episodeId] - The unique identifier of the episode to play
  void openVideoPlayer(String episodeId);

  /// Closes the video player screen for the specified episode.
  ///
  /// Removes the video player route from the navigation stack if it exists.
  ///
  /// [episodeId] - The unique identifier of the episode to close
  void closeVideoPlayer(String episodeId);

  /// Opens the settings screen for the specified episode.
  ///
  /// If a settings route already exists for this episode, it will be reused.
  /// Otherwise, a new route is created and added to the navigation stack.
  ///
  /// [episodeId] - The unique identifier of the episode to open settings for
  void openSettings(String episodeId);

  /// Closes the settings screen for the specified episode.
  ///
  /// Removes the settings route from the navigation stack if it exists.
  ///
  /// [episodeId] - The unique identifier of the episode to close settings for
  void closeSettings(String episodeId);
}

/// Implementation of [IVideoPlayerNavigationInteractor].
///
/// Manages navigation to and from the video player screen using
/// the YxNavigation routing system.
@immutable
class VideoPlayerNavigationInteractor
    implements IVideoPlayerNavigationInteractor {
  /// Route configuration for video player
  final VideoPlayerRoute _route;

  /// Navigation controller for managing routes
  final NavigationController _controller;

  const VideoPlayerNavigationInteractor({
    required this._route,
    required this._controller,
  });

  @override
  void openVideoPlayer(String episodeId) {
    _controller.mutate(
      (routeNode) {
        // Check if route already exists
        final hasRoute = routeNode.find(
          (routeNode) {
            if (routeNode.route != _route.video) {
              return false;
            }
            final arg = _route.getEpisodeIDFromMap(routeNode.arguments);
            return arg == episodeId;
          },
          recursive: false,
        );

        // Route already exists
        if (hasRoute != null) {
          return routeNode;
        }

        // Remove all routes
        routeNode.removeWhere(
          (routeNode) => routeNode.route == _route.video,
          recursive: false,
        );

        // Create new route node
        final value = RouteNode.fromRoute(
          route: _route.video,
          arguments: {_route.episodeId: episodeId},
        );

        // Add new route node to current route node
        return routeNode..add(value);
      },
    );
  }

  @override
  void closeVideoPlayer(String episodeId) => _controller.popWhere(
    (routeNode) {
      if (routeNode.route != _route.video) {
        return false;
      }
      final arg = _route.getEpisodeIDFromMap(routeNode.arguments);
      return arg == episodeId;
    },
  );

  @override
  void openSettings(String episodeId) => _controller.mutate(
    (routeNode) {
      // Check if route already exists
      final hasRoute = routeNode.find(
        (routeNode) {
          if (routeNode.route != _route.settings) {
            return false;
          }
          final arg = _route.getEpisodeIDFromMap(routeNode.arguments);
          return arg == episodeId;
        },
        recursive: false,
      );

      // Route already exists
      if (hasRoute != null) {
        return routeNode;
      }

      // Remove all routes
      routeNode.removeWhere(
        (routeNode) => routeNode.route == _route.settings,
        recursive: false,
      );

      // Create new route node
      final value = RouteNode.fromRoute(
        route: _route.settings,
        arguments: {_route.episodeId: episodeId},
      );

      // Add new route node to current route node
      return routeNode..add(value);
    },
  );

  @override
  void closeSettings(String episodeId) => _controller.popWhere(
    (routeNode) {
      if (routeNode.route != _route.settings) {
        return false;
      }
      final arg = _route.getEpisodeIDFromMap(routeNode.arguments);
      return arg == episodeId;
    },
  );
}
