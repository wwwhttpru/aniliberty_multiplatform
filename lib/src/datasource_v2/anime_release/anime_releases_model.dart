import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_releases_model.freezed.dart';
part 'anime_releases_model.g.dart';

@freezed
abstract class AnimeReleasesModel with _$AnimeReleasesModel {
  const factory AnimeReleasesModel({
    @JsonKey(name: 'releases') required List<AnimeReleaseModel> releases,
  }) = _AnimeReleasesModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleasesModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleasesModelFromJson(json);
}
