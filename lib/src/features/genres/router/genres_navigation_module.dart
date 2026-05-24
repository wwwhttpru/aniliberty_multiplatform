import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/genres/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/genres/router/genres_route.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template genres_navigation_module}
/// Navigation module for genres feature.
/// {@endtemplate}
///
/// Registers routes for genres screens.
class GenresNavigationModule implements NavigationModule {
  /// {@macro genres_route}
  final GenresRoute _route;

  /// {@macro genre_releases_holder_factory}
  final IGenreReleasesHolderFactory _genreReleasesHolderFactory;

  @override
  String get name => 'genres';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.genres,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const GenresScreen(),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.genreReleases,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) {
          final value = _route.getGenreIdFromMap(routeNode.arguments);

          if (value == null) {
            throw ArgumentError.value(value, 'GenreId');
          }

          return GenreReleasesScope(
            holderFactory: _genreReleasesHolderFactory,
            genreId: value,
            child: const GenreReleasesScreen(),
          );
        },
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  /// {@macro genres_navigation_module}
  const GenresNavigationModule({
    required this._route,
    required this._genreReleasesHolderFactory,
  });
}
