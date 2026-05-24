import 'package:aniliberty_multiplatform/src/features/genres/router/genres_route.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template genres_navigation_interactor}
/// Contract for navigation within the genres feature.
///
/// Handles navigation to the genre list screen and to a specific genre's
/// releases screen. Implementations typically no-op when the target
/// route is already on the stack.
/// {@endtemplate}
abstract interface class IGenresNavigationInteractor {
  /// Navigates to the genre list screen.
  void openGenres();

  /// Closes the genres screen.
  void closeGenres();

  /// Navigates to the releases screen for the genre identified by [genreId].
  void openGenre(int genreId);
}

/// {@macro genres_navigation_interactor}
///
/// Pushes [GenresRoute] screens; does nothing if the target route
/// is already present in the navigation state.
@immutable
class GenresNavigationInteractor implements IGenresNavigationInteractor {
  /// {@macro genres_route}
  final GenresRoute _route;

  /// {@macro yx_navigation_controller}
  final NavigationController _controller;

  /// Creates an interactor with the given [_controller] and [_route].
  ///
  /// {@macro genres_navigation_interactor}
  const GenresNavigationInteractor({
    required this._controller,
    required this._route,
  });

  @override
  void openGenre(int genreId) {
    final route = _route.genreReleases;

    final routeNode = _controller.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _controller.push(
      route,
      arguments: {_route.genreId: genreId.toString()},
    );
  }

  @override
  void openGenres() {
    final route = _route.genres;

    final routeNode = _controller.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _controller.push(route);
  }

  @override
  void closeGenres() => _controller.popWhere(
    (routeNode) => routeNode.route == _route.genres,
  );
}
