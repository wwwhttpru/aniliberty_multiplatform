import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/search/data/datasource/search_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template search_repository}
/// Repository for search functionality.
///
/// Provides search operations with caching support.
/// {@endtemplate}
@immutable
final class SearchRepository implements ISearchRepository {
  /// {@macro i_search_remote_db}
  final ISearchRemoteDB _remoteDB;

  /// Cache for search results.
  ///
  /// Maps search queries to their responses for faster retrieval.
  /// Format: `<query, response>`
  final Map<String, AnimeSearchModel> _cache;

  /// {@macro search_repository}
  ///
  /// Creates a new instance of [SearchRepository].
  ///
  /// [_remoteDB] - The remote data source for search operations
  SearchRepository({
    required this._remoteDB,
  }) : _cache = <String, AnimeSearchModel>{};

  @override
  Future<AnimeSearchModel> searchReleases(String query) async {
    if (query.isEmpty) {
      return const AnimeSearchModel(releases: []);
    }

    final fromCache = _cache[query];
    if (fromCache != null) {
      return fromCache;
    }

    final model = await _remoteDB.searchReleases(query);
    _cache[query] = model;
    return model;
  }
}
