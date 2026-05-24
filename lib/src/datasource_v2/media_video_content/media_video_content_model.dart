// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/media_video_content/media_video_origin_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_video_content_model.freezed.dart';
part 'media_video_content_model.g.dart';

/// Данные по видео роликам
@freezed
abstract class MediaVideoContentModel with _$MediaVideoContentModel {
  const factory MediaVideoContentModel({
    /// example: 57
    @JsonKey(name: 'id') required int id,

    /// example: https://www.youtube.com/watch?v=8f6FpV4sB0I
    @JsonKey(name: 'url') required String url,

    /// example: ТОП 10 САМЫХ ОЖИДАЕМЫХ АНИМЕ ОСЕНИ 2021
    @JsonKey(name: 'title') required String title,

    /// Количество просмотров ролика
    ///
    /// example: 34456
    @JsonKey(name: 'views') int? views,

    /// Количество комментариев к ролику
    ///
    /// example: 532
    @JsonKey(name: 'comments') int? comments,

    /// Идентификатор видео
    ///
    /// example: 8f6FpV4sB0I
    @JsonKey(name: 'video_id') required String videoId,

    /// Дата добавления ролика
    ///
    /// example: 2021-09-22T16:20:38+00:00
    @JsonKey(name: 'created_at') required String createdAt,

    /// Дата последнего обновления данных
    ///
    /// example: 2021-09-22T16:20:38+00:00
    @JsonKey(name: 'updated_at') required String updatedAt,

    /// Видео является анонсом сезона
    ///
    /// example: true
    @JsonKey(name: 'is_announce') required bool isAnnounce,

    /// Изображение
    @JsonKey(name: 'image') required PosterPreviewModel image,

    /// Источник видео
    @JsonKey(name: 'origin') required MediaVideoOriginModel origin,
  }) = _MediaVideoContentModel;

  /// Generate Class from Map<String, Object?>
  factory MediaVideoContentModel.fromJson(Map<String, Object?> json) =>
      _$MediaVideoContentModelFromJson(json);
}
