import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/genres/data/datasource/genres_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:meta/meta.dart';

/// Implementation of [IGenresRepository]: delegates data reads to [IGenresRemoteDB].
///
/// Genres data layer; local caching is not used in the current implementation.
@immutable
class GenresRepository implements IGenresRepository {
  final IGenresRemoteDB _remoteDB;

  /// Creates a repository with the given [_remoteDB].
  const GenresRepository({
    required this._remoteDB,
  });

  @override
  Future<AnimeGenresModel> readGenresFromNetwork() => _remoteDB.readGenres();

  @override
  Future<AnimeGenreModel> readGenreByIdFromNetwork({
    required int id,
  }) => _remoteDB.readGenreById(id: id);

  @override
  Future<AnimeGenresModel> readRandomGenresFromNetwork({
    required int limit,
  }) => _remoteDB.readRandomGenres(limit: limit);

  @override
  Future<AnimeGenreReleasesModel> readReleasesByGenreIdFromNetwork({
    required int genreId,
    required int page,
    required int limit,
  }) => _remoteDB.readReleasesByGenreId(
    genreId: genreId,
    page: page,
    limit: limit,
  );
}
