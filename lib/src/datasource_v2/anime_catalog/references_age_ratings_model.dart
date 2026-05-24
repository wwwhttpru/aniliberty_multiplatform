import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_age_ratings_model.freezed.dart';
part 'references_age_ratings_model.g.dart';

@freezed
abstract class ReferencesAgeRatingsModel with _$ReferencesAgeRatingsModel {
  const factory ReferencesAgeRatingsModel({
    /// Список возрастных рейтингов
    @JsonKey(name: 'age_ratings')
    required List<ReferencesAgeRatingModel> ageRatings,
  }) = _ReferencesAgeRatingsModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesAgeRatingsModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesAgeRatingsModelFromJson(json);
}

@freezed
abstract class ReferencesAgeRatingModel with _$ReferencesAgeRatingModel {
  const factory ReferencesAgeRatingModel({
    /// Значение типа
    ///
    /// example: PG
    @JsonKey(name: 'value') required String value,

    /// Название типа
    ///
    /// example: PG-17
    @JsonKey(name: 'label') required String label,

    /// Описание типа
    ///
    /// example: PG
    @JsonKey(name: 'description') required String description,
  }) = _ReferencesAgeRatingModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesAgeRatingModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesAgeRatingModelFromJson(json);
}
