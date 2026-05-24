import 'package:freezed_annotation/freezed_annotation.dart';

part 'references_genres_model.freezed.dart';
part 'references_genres_model.g.dart';

@freezed
abstract class ReferencesGenresModel with _$ReferencesGenresModel {
  const factory ReferencesGenresModel({
    /// Список жанров
    @JsonKey(name: 'genres') required List<ReferencesGenreModel> genres,
  }) = _ReferencesGenresModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesGenresModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesGenresModelFromJson(json);
}

@freezed
abstract class ReferencesGenreModel with _$ReferencesGenreModel {
  const factory ReferencesGenreModel({
    /// ID жанра
    ///
    /// example: 23
    @JsonKey(name: 'id') required int id,

    /// Название жанра
    ///
    /// example: Мистика
    @JsonKey(name: 'name') required String name,
  }) = _ReferencesGenreModel;

  /// Generate Class from Map<String, Object?>
  factory ReferencesGenreModel.fromJson(Map<String, Object?> json) =>
      _$ReferencesGenreModelFromJson(json);
}
