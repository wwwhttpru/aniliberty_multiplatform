// ignore_for_file: always_put_required_named_parameters_first

import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_catalog_query_model.freezed.dart';

@freezed
abstract class AnimeCatalogQueryModel with _$AnimeCatalogQueryModel {
  const AnimeCatalogQueryModel._();

  const factory AnimeCatalogQueryModel({
    /// Страница в выдаче
    ///
    /// Example : 1
    required int page,

    /// Количество релизов в выдаче
    ///
    /// Example : 15
    required int limit,

    /// Список идентификаторов жанров
    ///
    /// Example : 15,20
    required List<int> genres,

    /// Список типов релизов
    ///
    /// Available values : TV, ONA, WEB, OVA, OAD, MOVIE, DORAMA, SPECIAL
    ///
    /// Example : TV, WEB
    required List<String> types,

    /// Список сезонов релизов
    ///
    /// Available values : winter, spring, summer, autumn
    ///
    /// Example : winter, autumn
    required List<String> seasons,

    /// Минимальный год выхода релиза
    ///
    /// Example : 2016
    int? fromYear,

    /// Максимальный год выхода релиза.
    ///
    /// Example : 2020
    int? toYear,

    /// Поиск запрос
    ///
    /// Example : Мастера меча
    String? search,

    /// Тип сортировки
    ///
    /// Available values : FRESH_AT_DESC, FRESH_AT_ASC, RATING_DESC, RATING_ASC, YEAR_DESC, YEAR_ASC
    ///
    /// Example : RATING_DESC
    String? sorting,

    /// Список возрастных рейтингов
    ///
    /// Available values : R0_PLUS, R6_PLUS, R12_PLUS, R16_PLUS, R18_PLUS
    ///
    /// Example : R6_PLUS, R12_PLUS
    required List<String> ageRatings,

    /// Список статусов релизов
    ///
    /// Available values : IS_ONGOING, IS_NOT_ONGOING
    ///
    /// Example : IS_ONGOING
    required List<String> publishStatuses,

    /// Список статусов релизов
    ///
    /// Available values : IS_IN_PRODUCTION, IS_NOT_IN_PRODUCTION
    ///
    /// Example : IS_IN_PRODUCTION
    required List<String> productionStatuses,
  }) = _AnimeCatalogQueryModel;

  Map<String, Object?> toQuery() => <String, Object?>{
    'page': page,
    'limit': limit,
    'f[genres]': genres.join(','),
    'f[types]': types.join(','),
    'f[seasons]': seasons.join(','),
    'f[years][from_year]': fromYear,
    'f[years][to_year]': toYear,
    'f[search]': search,
    'f[sorting]': sorting,
    'f[age_ratings]': ageRatings.join(','),
    'f[publish_statuses]': publishStatuses.join(','),
    'f[production_statuses]': productionStatuses.join(','),
  };
}
