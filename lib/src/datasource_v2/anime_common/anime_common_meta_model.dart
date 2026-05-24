import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common_pagination_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_common_meta_model.freezed.dart';
part 'anime_common_meta_model.g.dart';

@freezed
abstract class AnimeCommonMetaModel with _$AnimeCommonMetaModel {
  const factory AnimeCommonMetaModel({
    /// Информация о пагинации
    @JsonKey(name: 'pagination') required AnimeCommonPaginationModel pagination,
  }) = _AnimeCommonMetaModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeCommonMetaModel.fromJson(Map<String, Object?> json) =>
      _$AnimeCommonMetaModelFromJson(json);
}
