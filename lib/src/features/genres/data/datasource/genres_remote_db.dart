import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// {@template genres_remote_db}
/// Contract for the genres data source over the Anilibria HTTP API.
///
/// Describes methods to read the genre list, a single genre by id,
/// and paginated releases by genre.
/// {@endtemplate}
abstract interface class IGenresRemoteDB {
  /// Returns the list of all genres.
  Future<AnimeGenresModel> readGenres();

  /// Returns the genre data for the given [id].
  Future<AnimeGenreModel> readGenreById({required int id});

  /// Returns a list of random genres.
  ///
  /// [limit] is the number of genres to return.
  Future<AnimeGenresModel> readRandomGenres({required int limit});

  /// Returns genre releases with pagination.
  ///
  /// [genreId] is the genre identifier, [page] is the page number,
  /// [limit] is the number of releases per page.
  Future<AnimeGenreReleasesModel> readReleasesByGenreId({
    required int genreId,
    required int page,
    required int limit,
  });
}

/// {@macro genres_remote_db}
///
/// Implementation of [IGenresRemoteDB]: requests to the Anilibria API via [AppNetwork].
///
/// API reference: <https://anilibria.top/api/docs/v1#/>
@immutable
class GenresRemoteDB implements IGenresRemoteDB {
  final AppNetwork _appNetwork;

  /// Creates a data source with the given [_appNetwork].
  ///
  /// {@macro genres_remote_db}
  const GenresRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<AnimeGenresModel> readGenres() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/genres',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeGenresModel.fromJson({'genres': data});
  }

  @override
  Future<AnimeGenreModel> readGenreById({required int id}) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/genres/$id',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeGenreModel.fromJson(data);
  }

  @override
  Future<AnimeGenresModel> readRandomGenres({required int limit}) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/genres/random',
      queryParameters: {'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeGenresModel.fromJson({'genres': data});
  }

  @override
  Future<AnimeGenreReleasesModel> readReleasesByGenreId({
    required int genreId,
    required int page,
    required int limit,
  }) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/genres/$genreId/releases',
      queryParameters: {'page': page, 'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeGenreReleasesModel.fromJson(data);
  }
}
