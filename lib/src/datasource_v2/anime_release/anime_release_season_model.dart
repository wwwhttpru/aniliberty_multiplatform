import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_season_model.freezed.dart';
part 'anime_release_season_model.g.dart';

@freezed
abstract class AnimeReleaseSeasonModel with _$AnimeReleaseSeasonModel {
  const factory AnimeReleaseSeasonModel({
    /// example: autumn
    @JsonKey(name: 'value') String? value,

    /// example: Осень
    @JsonKey(name: 'description') String? description,
  }) = _AnimeReleaseSeasonModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseSeasonModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseSeasonModelFromJson(json);
}
