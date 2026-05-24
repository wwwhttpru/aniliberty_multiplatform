import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_genre_releases_model.freezed.dart';
part 'anime_genre_releases_model.g.dart';

@freezed
abstract class AnimeGenreReleasesModel with _$AnimeGenreReleasesModel {
  const factory AnimeGenreReleasesModel({
    /// Список релизов по жанру
    @JsonKey(name: 'data') required List<AnimeReleaseModel> data,

    /// Meta information
    @JsonKey(name: 'meta') required AnimeCommonMetaModel meta,
  }) = _AnimeGenreReleasesModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeGenreReleasesModel.fromJson(Map<String, Object?> json) =>
      _$AnimeGenreReleasesModelFromJson(json);
}
