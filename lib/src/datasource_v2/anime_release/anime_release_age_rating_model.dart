import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_age_rating_model.freezed.dart';
part 'anime_release_age_rating_model.g.dart';

/// Возрастное ограничение
@freezed
abstract class AnimeReleaseAgeRatingModel with _$AnimeReleaseAgeRatingModel {
  const factory AnimeReleaseAgeRatingModel({
    /// example: R16_PLUS
    @JsonKey(name: 'value') required String value,

    /// example: 16+
    @JsonKey(name: 'label') required String label,

    /// example: false
    @JsonKey(name: 'is_adult') required bool isAdult,

    /// example: Для людей, достигших возраста шестнадцати лет (16+)
    @JsonKey(name: 'description') required String description,
  }) = _AnimeReleaseAgeRatingModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseAgeRatingModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseAgeRatingModelFromJson(json);
}
