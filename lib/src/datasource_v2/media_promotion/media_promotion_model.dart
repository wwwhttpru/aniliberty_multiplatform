// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_promotion_model.freezed.dart';
part 'media_promotion_model.g.dart';

/// Данные по промо-материалам
@freezed
abstract class MediaPromotionModel with _$MediaPromotionModel {
  const factory MediaPromotionModel({
    /// example: bad864a4-d1b9-473f-898f-da8ee800ef87
    @JsonKey(name: 'id') required String id,

    /// Кастомная ссылка на промо-материал
    ///
    /// example: https://espritgames.ru/dragoncontract/promotions/getdragon
    @JsonKey(name: 'url') String? url,

    /// Изображение
    @JsonKey(name: 'image') required PosterPreviewModel image,

    /// Кастомная подпись к ссылке
    ///
    /// example: Перейти на сайт
    @JsonKey(name: 'url_label') String? urlLabel,

    /// Кастомное название промо-материала
    ///
    /// example: Dragon Contract
    @JsonKey(name: 'title') String? title,

    /// Кастомное описание промо-материала
    ///
    /// example: ИСПЫТАЙ СВОЮ ПАМЯТЬ! Собери все пары карточек правильно, и получи дракона на старте!
    @JsonKey(name: 'description') String? description,

    /// Флаг рекламной промо кампании
    @JsonKey(name: 'is_ad') required bool isAd,

    /// Маркировка рекламы
    @JsonKey(name: 'ad_erid') String? adErid,

    /// Источник?
    @JsonKey(name: 'ad_origin') String? adOrigin,

    /// Данные по релизу
    @JsonKey(name: 'release') AnimeReleaseModel? release,

    /// Использовать темный оверлей
    ///
    /// example: true
    @JsonKey(name: 'has_overlay') required bool hasOverlay,
  }) = _MediaPromotionModel;

  /// Generate Class from Map<String, Object?>
  factory MediaPromotionModel.fromJson(Map<String, Object?> json) =>
      _$MediaPromotionModelFromJson(json);
}
