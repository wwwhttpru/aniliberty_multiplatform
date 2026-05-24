// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_episode_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_schedule_model.freezed.dart';
part 'anime_schedule_model.g.dart';

/// Данные по релизу в расписании
@freezed
abstract class AnimeScheduleModel with _$AnimeScheduleModel {
  const factory AnimeScheduleModel({
    /// Данные по релизу
    @JsonKey(name: 'release') required AnimeReleaseModel release,

    /// Показывает, вышла ли полная серия
    @JsonKey(name: 'full_season_is_released')
    required bool fullSeasonIsReleased,

    /// Эпизод релиза
    @JsonKey(name: 'published_release_episode')
    AnimeReleaseEpisodeModel? publishedReleaseEpisode,

    /// example: 8
    @JsonKey(name: 'next_release_episode_number') int? nextReleaseEpisodeNumber,
  }) = _AnimeScheduleModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeScheduleModel.fromJson(Map<String, Object?> json) =>
      _$AnimeScheduleModelFromJson(json);
}
