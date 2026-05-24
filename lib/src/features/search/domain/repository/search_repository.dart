import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// {@template i_search_repository}
/// Repository for search functionality.
/// {@endtemplate}
abstract interface class ISearchRepository {
  /// Searches for a list of titles by [query].
  ///
  /// [query] - Search query
  Future<AnimeSearchModel> searchReleases(String query);
}
