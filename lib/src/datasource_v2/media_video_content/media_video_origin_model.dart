import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_video_origin_model.freezed.dart';
part 'media_video_origin_model.g.dart';

/// Данные по видео-источнику
@freezed
abstract class MediaVideoOriginModel with _$MediaVideoOriginModel {
  const factory MediaVideoOriginModel({
    /// example: e8fd32be-7f14-4c02-bf00-dbd26ecabfdb
    @JsonKey(name: 'id') required String id,

    /// example: https://www.youtube.com/playlist?list=PL8_g6JPJBRglxkyQfNGugDyyQP11hL0-Q
    @JsonKey(name: 'url') required String url,

    /// example: Анонсы аниме-сезонов
    @JsonKey(name: 'title') required String title,

    /// Источник видео
    ///
    /// example: youtube
    @JsonKey(name: 'type') required VideoOriginTypeModel type,

    /// example: Плейлист с анонсами
    @JsonKey(name: 'description') required String description,

    /// Видео-источник является анонсом сезона
    ///
    /// example: true
    @JsonKey(name: 'is_announce') required bool isAnnounce,
  }) = _MediaVideoOriginModel;

  /// Generate Class from Map<String, Object?>
  factory MediaVideoOriginModel.fromJson(Map<String, Object?> json) =>
      _$MediaVideoOriginModelFromJson(json);
}

@freezed
abstract class VideoOriginTypeModel with _$VideoOriginTypeModel {
  const factory VideoOriginTypeModel({
    /// example: youtube_playlist
    @JsonKey(name: 'value') required String value,

    /// example: Youtube плейлист
    @JsonKey(name: 'description') required String description,
  }) = _VideoOriginTypeModel;

  /// Generate Class from Map<String, Object?>
  factory VideoOriginTypeModel.fromJson(Map<String, Object?> json) =>
      _$VideoOriginTypeModelFromJson(json);
}
