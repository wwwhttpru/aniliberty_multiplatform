import 'package:aniliberty_multiplatform/src/datasource_v2/anime_genre/anime_genre_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_genres_model.freezed.dart';
part 'anime_genres_model.g.dart';

@freezed
abstract class AnimeGenresModel with _$AnimeGenresModel {
  const factory AnimeGenresModel({
    /// Список жанров
    @JsonKey(name: 'genres') required List<AnimeGenreModel> genres,
  }) = _AnimeGenresModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeGenresModel.fromJson(Map<String, Object?> json) =>
      _$AnimeGenresModelFromJson(json);
}
