import 'package:aniliberty_multiplatform/src/datasource_v2/media_video_content/media_video_content_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_video_contents_model.freezed.dart';
part 'media_video_contents_model.g.dart';

/// Список видео роликов
@freezed
abstract class MediaVideoContentsModel with _$MediaVideoContentsModel {
  const factory MediaVideoContentsModel({
    /// Список видео роликов
    @JsonKey(name: 'media_video_contents')
    required List<MediaVideoContentModel> mediaVideoContents,
  }) = _MediaVideoContentsModel;

  /// Generate Class from Map<String, Object?>
  factory MediaVideoContentsModel.fromJson(Map<String, Object?> json) =>
      _$MediaVideoContentsModelFromJson(json);
}
