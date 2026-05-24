import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_genre_image_model.freezed.dart';
part 'anime_genre_image_model.g.dart';

/// Превью жанра
@freezed
abstract class AnimeGenreImageModel with _$AnimeGenreImageModel {
  const factory AnimeGenreImageModel({
    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR.jpg
    @JsonKey(name: 'preview') required String preview,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__3970bbec8d96605f60e92d1af21be963.jpg
    @JsonKey(name: 'thumbnail') required String thumbnail,

    /// Оптимизированный постер
    @JsonKey(name: 'optimized')
    required AnimeGenreImageOptimizedModel optimized,
  }) = _AnimeGenreImageModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeGenreImageModel.fromJson(Map<String, Object?> json) =>
      _$AnimeGenreImageModelFromJson(json);
}

@freezed
abstract class AnimeGenreImageOptimizedModel
    with _$AnimeGenreImageOptimizedModel {
  const factory AnimeGenreImageOptimizedModel({
    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__231400294e84de4d2ef108eb034c7cce.webp
    @JsonKey(name: 'preview') required String preview,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__754b7d4317b2760d5ddadcb0ad01501e.webp
    @JsonKey(name: 'thumbnail') required String thumbnail,
  }) = _AnimeGenreImageOptimizedModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeGenreImageOptimizedModel.fromJson(Map<String, Object?> json) =>
      _$AnimeGenreImageOptimizedModelFromJson(json);
}
