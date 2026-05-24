import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_publish_day_model.freezed.dart';
part 'anime_release_publish_day_model.g.dart';

/// День выхода релиза
@freezed
abstract class AnimeReleasePublishDayModel with _$AnimeReleasePublishDayModel {
  const factory AnimeReleasePublishDayModel({
    /// example: 7
    @JsonKey(name: 'value') required int value,

    /// example: Воскресенье
    @JsonKey(name: 'description') required String description,
  }) = _AnimeReleasePublishDayModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleasePublishDayModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleasePublishDayModelFromJson(json);
}
