import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_name_model.freezed.dart';
part 'anime_release_name_model.g.dart';

@freezed
abstract class AnimeReleaseNameModel with _$AnimeReleaseNameModel {
  const factory AnimeReleaseNameModel({
    /// example: Мастера Меча Онлайн: Алисизация
    @JsonKey(name: 'main') required String main,

    /// example: Sword Art Online: Alicization
    @JsonKey(name: 'english') String? english,

    /// example: Война в Андерворлде, War of Underworld
    @JsonKey(name: 'alternative') String? alternative,
  }) = _AnimeReleaseNameModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseNameModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseNameModelFromJson(json);
}
