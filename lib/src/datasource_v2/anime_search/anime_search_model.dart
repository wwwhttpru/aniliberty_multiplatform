import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_search_model.freezed.dart';
part 'anime_search_model.g.dart';

@freezed
abstract class AnimeSearchModel with _$AnimeSearchModel {
  const factory AnimeSearchModel({
    /// Список релизов
    @JsonKey(name: 'releases') required List<AnimeReleaseModel> releases,
  }) = _AnimeSearchModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeSearchModel.fromJson(Map<String, Object?> json) =>
      _$AnimeSearchModelFromJson(json);
}
