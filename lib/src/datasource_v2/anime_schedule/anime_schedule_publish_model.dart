import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_publish_day_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_schedule/anime_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_schedule_publish_model.freezed.dart';
part 'anime_schedule_publish_model.g.dart';

/// Данные по расписанию с днем выхода
@freezed
abstract class AnimeSchedulePublishModel with _$AnimeSchedulePublishModel {
  const factory AnimeSchedulePublishModel({
    /// День выхода релиза
    @JsonKey(name: 'publish_day')
    required AnimeReleasePublishDayModel publishDay,

    /// Список расписаний
    @JsonKey(name: 'schedules') required List<AnimeScheduleModel> schedules,
  }) = _AnimeSchedulePublishModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeSchedulePublishModel.fromJson(Map<String, Object?> json) =>
      _$AnimeSchedulePublishModelFromJson(json);
}
