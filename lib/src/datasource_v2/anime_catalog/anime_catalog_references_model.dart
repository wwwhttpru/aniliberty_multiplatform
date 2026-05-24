import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_age_ratings_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_genres_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_production_statuses_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_publish_statuses_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_seasons_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_sorting_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_types_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_catalog/references_years_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_catalog_references_model.freezed.dart';

@freezed
abstract class AnimeCatalogReferencesModel with _$AnimeCatalogReferencesModel {
  const factory AnimeCatalogReferencesModel({
    required ReferencesAgeRatingsModel ageRatings,
    required ReferencesGenresModel genres,
    required ReferencesProductionStatusesModel productionStatuses,
    required ReferencesPublishStatusesModel publishStatuses,
    required ReferencesSeasonsModel seasons,
    required ReferencesSortingModel sorting,
    required ReferencesTypesModel types,
    required ReferencesYearsValue years,
  }) = _AnimeCatalogReferencesModel;
}

@freezed
abstract class ReferencesYearsValue with _$ReferencesYearsValue {
  const factory ReferencesYearsValue({
    /// Минимальный год
    required int fromYear,

    /// Максимальный год
    required int toYear,
  }) = _ReferencesYearsValue;

  factory ReferencesYearsValue.fromYears(ReferencesYearsModel value) {
    final from = value.years.firstOrNull;
    final to = value.years.lastOrNull;

    if (from == null || to == null) {
      return ReferencesYearsValue(
        fromYear: 1990,
        toYear: DateTime.timestamp().year,
      );
    }

    if (from >= to || to <= from) {
      return ReferencesYearsValue(
        fromYear: 1990,
        toYear: DateTime.timestamp().year,
      );
    }

    return ReferencesYearsValue(fromYear: from, toYear: to);
  }
}
