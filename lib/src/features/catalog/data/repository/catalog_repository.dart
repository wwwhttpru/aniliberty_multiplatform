import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/data/datasource/catalog_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/repository/catalog_repository.dart';
import 'package:meta/meta.dart';

/// {@macro i_catalog_repository}
///
/// Implementation of [ICatalogRepository] that aggregates data from
/// [ICatalogRemoteDB] to provide catalog functionality.
@immutable
class CatalogRepository implements ICatalogRepository {
  /// {@macro i_catalog_remote_db}
  final ICatalogRemoteDB _remoteDB;

  /// {@macro i_catalog_repository}
  ///
  /// Creates a new instance of [CatalogRepository].
  ///
  /// [_remoteDB] - The remote data source for catalog data
  const CatalogRepository({
    required this._remoteDB,
  });

  @override
  Future<AnimeCatalogReleaseModel> readReleasesFromNetwork({
    required AnimeCatalogQueryModel query,
  }) => _remoteDB.releases(query: query);

  @override
  Future<AnimeCatalogReferencesModel> readReferencesFromNetwork() async {
    final ageRatings = await _remoteDB.referencesAgeRatings();
    final genres = await _remoteDB.referencesGenres();
    final productionStatuses = await _remoteDB.referencesProductionStatuses();
    final publishStatuses = await _remoteDB.referencesPublishStatuses();
    final seasons = await _remoteDB.referencesSeasons();
    final sorting = await _remoteDB.referencesSorting();
    final types = await _remoteDB.referencesTypes();
    final years = await _remoteDB.referencesYears();

    return AnimeCatalogReferencesModel(
      ageRatings: ageRatings,
      genres: genres,
      productionStatuses: productionStatuses,
      publishStatuses: publishStatuses,
      seasons: seasons,
      sorting: sorting,
      types: types,
      years: ReferencesYearsValue.fromYears(years),
    );
  }
}
