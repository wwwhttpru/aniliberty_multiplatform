import 'package:aniliberty_multiplatform/src/datasource_v2/media_promotion/media_promotion_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_promotions_model.freezed.dart';
part 'media_promotions_model.g.dart';

@freezed
abstract class MediaPromotionsModel with _$MediaPromotionsModel {
  const factory MediaPromotionsModel({
    /// Список промо-материалов
    @JsonKey(name: 'promotions') required List<MediaPromotionModel> promotions,
  }) = _MediaPromotionsModel;

  /// Generate Class from Map<String, Object?>
  factory MediaPromotionsModel.fromJson(Map<String, Object?> json) =>
      _$MediaPromotionsModelFromJson(json);
}
