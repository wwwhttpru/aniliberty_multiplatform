import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/router/video_content_route.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template video_content_navigation_module}
/// Navigation module for video content feature.
/// {@endtemplate}
///
/// Registers routes for video content screens.
class VideoContentNavigationModule implements NavigationModule {
  /// {@macro video_content_route}
  final VideoContentRoute _route;

  @override
  String get name => 'video_content';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.videoContent,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const VideoContentAllScreen(),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [];

  /// {@macro video_content_navigation_module}
  const VideoContentNavigationModule({
    required this._route,
  });
}
