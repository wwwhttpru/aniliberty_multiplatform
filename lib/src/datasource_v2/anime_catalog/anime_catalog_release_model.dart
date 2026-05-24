import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_catalog_release_model.freezed.dart';
part 'anime_catalog_release_model.g.dart';

@freezed
abstract class AnimeCatalogReleaseModel with _$AnimeCatalogReleaseModel {
  const factory AnimeCatalogReleaseModel({
    /// Список релизов
    @JsonKey(name: 'data') required List<AnimeReleaseModel> data,

    /// Meta information
    @JsonKey(name: 'meta') required AnimeCommonMetaModel meta,
  }) = _AnimeCatalogReleaseModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeCatalogReleaseModel.fromJson(Map<String, Object?> json) =>
      _$AnimeCatalogReleaseModelFromJson(json);
}
