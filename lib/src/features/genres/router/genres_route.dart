import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Route configuration for genres screens.
///
/// Provides route definitions and utilities for navigating to genres screens.
@immutable
class GenresRoute {
  /// Genres list screen ID.
  YxRoute get genres => const YxRoute(id: 'genres');

  /// Genre releases screen ID.
  YxRoute get genreReleases => const YxRoute(id: 'genre-releases');

  /// Genre ID argument key.
  String get genreId => 'genre-id';

  /// Get genre ID from map.
  int? getGenreIdFromMap(Map<String, String> map) {
    final value = map[genreId];
    return switch (value) {
      null => null,
      final value => int.tryParse(value),
    };
  }

  const GenresRoute();
}
