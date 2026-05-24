import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// {@template i_catalog_repository}
/// Repository for catalog functionality.
/// {@endtemplate}
abstract interface class ICatalogRepository {
  /// Reads releases from network matching the specified query parameters.
  ///
  /// [query] - The query parameters for filtering and pagination
  ///
  /// Returns [AnimeCatalogReleaseModel] containing the list of releases
  Future<AnimeCatalogReleaseModel> readReleasesFromNetwork({
    required AnimeCatalogQueryModel query,
  });

  /// Reads available filter settings for [AnimeCatalogQueryModel].
  ///
  /// Aggregates all reference data including genres, types, statuses, seasons,
  /// sorting options, years, and age ratings.
  ///
  /// Returns [AnimeCatalogReferencesModel] containing all available filter options
  Future<AnimeCatalogReferencesModel> readReferencesFromNetwork();
}
