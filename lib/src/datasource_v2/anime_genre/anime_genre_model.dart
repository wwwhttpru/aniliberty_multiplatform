import 'package:aniliberty_multiplatform/src/datasource_v2/anime_genre/anime_genre_image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_genre_model.freezed.dart';
part 'anime_genre_model.g.dart';

/// Данные по жанрам
@freezed
abstract class AnimeGenreModel with _$AnimeGenreModel {
  const factory AnimeGenreModel({
    /// example: 21
    @JsonKey(name: 'id') required int id,

    /// example: Комедия
    @JsonKey(name: 'name') required String name,

    /// Общее количество релизов в этом жанре
    @JsonKey(name: 'total_releases') required int totalReleases,

    /// Превью жанра
    @JsonKey(name: 'image') required AnimeGenreImageModel image,
  }) = _AnimeGenreModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeGenreModel.fromJson(Map<String, Object?> json) =>
      _$AnimeGenreModelFromJson(json);
}
