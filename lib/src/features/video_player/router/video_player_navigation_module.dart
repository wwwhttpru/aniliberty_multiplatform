import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/router/video_player_guard.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/router/video_player_route.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// Navigation module for video player feature.
///
/// Registers routes for video player and settings screens, and provides
/// guards for route validation.
class VideoPlayerNavigationModule implements NavigationModule {
  final VideoPlayerRoute _route;
  final EpisodeContainerSM _episodeContainerSM;

  @override
  String get name => 'video_player';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.video,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PagesFactory<void>.material(
          fullscreenDialog: true,
        ),
        builder: (context, routeNode) {
          final value = _route.getEpisodeIDFromMap(routeNode.arguments);

          if (value == null) {
            throw ArgumentError.value(value, _route.episodeId);
          }

          return PlayerEpisodeScope(
            episodeContainerSM: _episodeContainerSM,
            episodeId: value,
            child: const VideoPlayerScreen(),
          );
        },
      ),
    ),
    RouteDeclaration.routeBuilder(
      route: _route.settings,
      routeBuilder: RouteBuilder.widget(
        pageFactory: const PlatformPageSheetFactory<void>(
          isScrollControlled: true,
          enableDrag: false,
          useSafeArea: true,
          showDragHandle: true,
        ),
        builder: (context, routeNode) {
          final value = _route.getEpisodeIDFromMap(routeNode.arguments);

          if (value == null) {
            throw ArgumentError.value(value, _route.episodeId);
          }

          return PlayerEpisodeScope(
            episodeContainerSM: _episodeContainerSM,
            episodeId: value,
            child: const SettingsScreen(),
          );
        },
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [
    VideoPlayerGuard(route: _route),
  ];

  const VideoPlayerNavigationModule({
    required this._route,
    required this._episodeContainerSM,
  });
}
