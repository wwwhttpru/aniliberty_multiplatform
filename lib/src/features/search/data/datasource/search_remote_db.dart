import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// {@template i_search_remote_db}
/// Interface for remote data source that provides search functionality.
/// {@endtemplate}
abstract interface class ISearchRemoteDB {
  /// Searches for anime releases by query.
  ///
  /// Returns a list of found titles matching the search query.
  ///
  /// [query] - The search query string
  ///
  /// Returns [AnimeSearchModel] containing the search results
  Future<AnimeSearchModel> searchReleases(String query);
}

/// {@macro i_search_remote_db}
///
/// Implementation of [ISearchRemoteDB] that uses the Anilibria API.
///
/// More information about the API: <https://anilibria.top/api/docs/v1#/>
@immutable
final class SearchRemoteDB implements ISearchRemoteDB {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_search_remote_db}
  ///
  /// Creates a new instance of [SearchRemoteDB].
  ///
  /// [_appNetwork] - The network client for API requests
  const SearchRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<AnimeSearchModel> searchReleases(String query) async {
    assert(query.isNotEmpty, 'Query must not be empty');

    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/app/search/releases',
      queryParameters: <String, Object?>{'query': query},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeSearchModel.fromJson({'releases': data});
  }
}
