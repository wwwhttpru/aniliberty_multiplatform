import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_type_model.freezed.dart';
part 'anime_release_type_model.g.dart';

@freezed
abstract class AnimeReleaseTypeModel with _$AnimeReleaseTypeModel {
  const factory AnimeReleaseTypeModel({
    /// example: TV
    @JsonKey(name: 'value') String? value,

    /// example: ТВ
    @JsonKey(name: 'description') String? description,
  }) = _AnimeReleaseTypeModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseTypeModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseTypeModelFromJson(json);
}
