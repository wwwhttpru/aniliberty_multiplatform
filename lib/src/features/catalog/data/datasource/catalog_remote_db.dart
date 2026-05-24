import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// {@template i_catalog_remote_db}
/// Interface for remote data source that provides catalog functionality.
/// {@endtemplate}
abstract interface class ICatalogRemoteDB {
  /// Returns a list of releases matching the specified query parameters.
  ///
  /// [query] - The query parameters for filtering and pagination
  ///
  /// Returns [AnimeCatalogReleaseModel] containing the list of releases
  Future<AnimeCatalogReleaseModel> releases({
    required AnimeCatalogQueryModel query,
  });

  /// Returns a list of available age ratings in the catalog.
  ///
  /// Returns [ReferencesAgeRatingsModel] containing the age rating options
  Future<ReferencesAgeRatingsModel> referencesAgeRatings();

  /// Returns a list of all genres in the catalog.
  ///
  /// Returns [ReferencesGenresModel] containing the genre options
  Future<ReferencesGenresModel> referencesGenres();

  /// Returns a list of available production statuses for releases in the catalog.
  ///
  /// Returns [ReferencesProductionStatusesModel] containing the production status options
  Future<ReferencesProductionStatusesModel> referencesProductionStatuses();

  /// Returns a list of available publish statuses for releases in the catalog.
  ///
  /// Returns [ReferencesPublishStatusesModel] containing the publish status options
  Future<ReferencesPublishStatusesModel> referencesPublishStatuses();

  /// Returns a list of available seasons for releases in the catalog.
  ///
  /// Returns [ReferencesSeasonsModel] containing the season options
  Future<ReferencesSeasonsModel> referencesSeasons();

  /// Returns a list of available sorting options in the catalog.
  ///
  /// Returns [ReferencesSortingModel] containing the sorting options
  Future<ReferencesSortingModel> referencesSorting();

  /// Returns a list of available release types in the catalog.
  ///
  /// Returns [ReferencesTypesModel] containing the type options
  Future<ReferencesTypesModel> referencesTypes();

  /// Returns a list of available years in the catalog.
  ///
  /// Returns [ReferencesYearsModel] containing the year options
  Future<ReferencesYearsModel> referencesYears();
}

/// {@macro i_catalog_remote_db}
///
/// Implementation of [ICatalogRemoteDB] that uses the Anilibria API.
///
/// More information about the API: <https://anilibria.top/api/docs/v1#/>
@immutable
final class CatalogRemoteDB implements ICatalogRemoteDB {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_catalog_remote_db}
  ///
  /// Creates a new instance of [CatalogRemoteDB].
  ///
  /// [_appNetwork] - The network client for API requests
  const CatalogRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<AnimeCatalogReleaseModel> releases({
    required AnimeCatalogQueryModel query,
  }) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/catalog/releases',
      queryParameters: query.toQuery(),
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeCatalogReleaseModel.fromJson(data);
  }

  @override
  Future<ReferencesAgeRatingsModel> referencesAgeRatings() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/age-ratings',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesAgeRatingsModel.fromJson({'age_ratings': data});
  }

  @override
  Future<ReferencesGenresModel> referencesGenres() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/genres',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesGenresModel.fromJson({'genres': data});
  }

  @override
  Future<ReferencesProductionStatusesModel>
  referencesProductionStatuses() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/production-statuses',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesProductionStatusesModel.fromJson({
      'production_statuses': data,
    });
  }

  @override
  Future<ReferencesPublishStatusesModel> referencesPublishStatuses() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/publish-statuses',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesPublishStatusesModel.fromJson({'publish_statuses': data});
  }

  @override
  Future<ReferencesSeasonsModel> referencesSeasons() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/seasons',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesSeasonsModel.fromJson({'seasons': data});
  }

  @override
  Future<ReferencesSortingModel> referencesSorting() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/sorting',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesSortingModel.fromJson({'sorting': data});
  }

  @override
  Future<ReferencesTypesModel> referencesTypes() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/types',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesTypesModel.fromJson({'types': data});
  }

  @override
  Future<ReferencesYearsModel> referencesYears() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/catalog/references/years',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return ReferencesYearsModel.fromJson({'years': data});
  }
}
