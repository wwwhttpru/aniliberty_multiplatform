import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_filter_entity.freezed.dart';

/// {@template catalog_filter_entity}
/// Entity representing catalog filter parameters.
///
/// Contains all filter options for catalog queries including genres, types,
/// statuses, seasons, years, sorting, and search text.
/// {@endtemplate}
@freezed
abstract class CatalogFilterEntity with _$CatalogFilterEntity {
  const CatalogFilterEntity._();

  /// {@macro catalog_filter_entity}
  ///
  /// [genres] - Map of selected genres by genre ID
  /// [types] - Map of selected release types by type value
  /// [publishStatuses] - Map of selected publish statuses by status value
  /// [productionStatuses] - Map of selected production statuses by status value
  /// [seasons] - Map of selected seasons by season value
  /// [ageRatings] - Map of selected age ratings by rating value
  /// [year] - Year range (from and to)
  /// [sorting] - Selected sorting option
  /// [search] - Search text query
  const factory CatalogFilterEntity({
    /// Map of selected genres by genre ID
    required Map<int, ReferencesGenreModel> genres,

    /// Map of selected release types by type value
    required Map<String, ReferencesTypeModel> types,

    /// Map of selected publish statuses by status value
    required Map<String, ReferencesPublishStatusModel> publishStatuses,

    /// Map of selected production statuses by status value
    required Map<String, ReferencesProductionStatusModel> productionStatuses,

    /// Map of selected seasons by season value
    required Map<String, ReferencesSeasonModel> seasons,

    /// Map of selected age ratings by rating value
    required Map<String, ReferencesAgeRatingModel> ageRatings,

    /// Year range (from and to)
    ReferencesYearsValue? year,

    /// Selected sorting option
    ReferencesSortingValueModel? sorting,

    /// Search text query
    String? search,
  }) = _CatalogFilterEntity;

  /// Creates an initial empty filter entity with all filters unset.
  factory CatalogFilterEntity.initial() => const CatalogFilterEntity(
    genres: {},
    types: {},
    productionStatuses: {},
    publishStatuses: {},
    seasons: {},
    ageRatings: {},
  );

  /// Converts the filter entity to [AnimeCatalogQueryModel] for API requests.
  ///
  /// [page] - The page number for pagination
  /// [limit] - The number of items per page
  ///
  /// Returns [AnimeCatalogQueryModel] with all filter parameters applied
  AnimeCatalogQueryModel toQuery(int page, int limit) => AnimeCatalogQueryModel(
    page: page,
    limit: limit,
    genres: genres.keys.toList(growable: false),
    types: types.keys.toList(growable: false),
    seasons: seasons.keys.toList(growable: false),
    fromYear: year?.fromYear,
    toYear: year?.toYear,
    search: search,
    sorting: sorting?.value,
    ageRatings: ageRatings.keys.toList(growable: false),
    publishStatuses: publishStatuses.keys.toList(growable: false),
    productionStatuses: productionStatuses.keys.toList(growable: false),
  );
}
