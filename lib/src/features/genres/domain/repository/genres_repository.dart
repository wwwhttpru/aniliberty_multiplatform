import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// {@template genres_repository}
/// Contract for reading genres and genre releases from the data layer.
///
/// All methods fetch from the network; the data layer may add caching
/// in the future without changing this interface.
/// {@endtemplate}
abstract interface class IGenresRepository {
  /// {@macro genres_repository}
  /// Returns the full list of genres from the network.
  Future<AnimeGenresModel> readGenresFromNetwork();

  /// Returns the genre data for the given [id].
  Future<AnimeGenreModel> readGenreByIdFromNetwork({
    required int id,
  });

  /// Returns a list of random genres.
  ///
  /// [limit] is the number of genres to return.
  Future<AnimeGenresModel> readRandomGenresFromNetwork({
    required int limit,
  });

  /// Returns paginated releases for the given genre.
  ///
  /// [genreId] is the genre identifier, [page] is the page index,
  /// [limit] is the page size.
  Future<AnimeGenreReleasesModel> readReleasesByGenreIdFromNetwork({
    required int genreId,
    required int page,
    required int limit,
  });
}
