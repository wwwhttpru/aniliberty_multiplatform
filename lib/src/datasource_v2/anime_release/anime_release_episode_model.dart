// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_release_episode_model.freezed.dart';
part 'anime_release_episode_model.g.dart';

@freezed
abstract class AnimeReleaseEpisodeModel with _$AnimeReleaseEpisodeModel {
  const factory AnimeReleaseEpisodeModel({
    /// Идентификатор эпизода
    ///
    /// example: 9b5e26ee-598f-4b8b-b77e-188d3e456318
    @JsonKey(name: 'id') required String id,

    /// Название эпизода
    ///
    /// example: Пролог
    @JsonKey(name: 'name') String? name,

    /// Номер эпизода. Может быть целым или дробным числом (например, 5 или 23.5)
    ///
    /// example: 12.5
    @JsonKey(name: 'ordinal') required double ordinal,

    /// Время опенинга
    @JsonKey(name: 'opening') required AnimeReleaseEpisodeSkips opening,

    /// Время эндинга
    @JsonKey(name: 'ending') required AnimeReleaseEpisodeSkips ending,

    /// Превью эпизода
    @JsonKey(name: 'preview') required PosterPreviewModel preview,

    /// Ссылка на поток 480p
    @JsonKey(name: 'hls_480') String? hls480,

    /// Ссылка на поток 720p
    @JsonKey(name: 'hls_720') String? hls720,

    /// Ссылка на поток 1080p
    @JsonKey(name: 'hls_1080') String? hls1080,

    /// Длительность эпизода в секундах
    ///
    /// example: 1432
    @JsonKey(name: 'duration') required int duration,

    /// Id эпизода на Rutube
    ///
    /// example: c6cc4d620b1d4338901770a44b3e82f4
    @JsonKey(name: 'rutube_id') String? rutubeId,

    /// Id эпизода на Youtube
    ///
    /// example: dQw4w9WgXcQ
    @JsonKey(name: 'youtube_id') String? youtubeId,

    /// Дата обновления эпизода
    ///
    /// example: 2021-11-25T18:46:30+00:00
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    /// Порядковый номер эпизода для сортировки
    ///
    /// example: 12
    @JsonKey(name: 'sort_order') required int sortOrder,

    /// Название эпизода на английском
    ///
    /// example: Prologue
    @JsonKey(name: 'name_english') String? nameEnglish,

    /// Релиз
    @JsonKey(name: 'release') AnimeReleaseModel? release,
  }) = _AnimeReleaseEpisodeModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseEpisodeModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseEpisodeModelFromJson(json);
}

@freezed
abstract class AnimeReleaseEpisodeSkips with _$AnimeReleaseEpisodeSkips {
  const factory AnimeReleaseEpisodeSkips({
    /// Время начала опенинга. Количество секунд от начала эпизода
    /// or
    /// Время начала эндинга. Количество секунд от конца эпизода
    ///
    /// example: 1394
    @JsonKey(name: 'start') int? start,

    /// Время окончания опенинга. Количество секунд от начала эпизода
    /// or
    /// Время окончания эндинга. Количество секунд от конца эпизода
    ///
    /// example: 1440
    @JsonKey(name: 'stop') int? stop,
  }) = _AnimeReleaseEpisodeSkips;

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseEpisodeSkips.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseEpisodeSkipsFromJson(json);
}
