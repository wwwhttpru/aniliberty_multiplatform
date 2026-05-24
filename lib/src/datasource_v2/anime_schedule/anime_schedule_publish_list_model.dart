import 'package:aniliberty_multiplatform/src/datasource_v2/anime_schedule/anime_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_schedule_publish_list_model.freezed.dart';
part 'anime_schedule_publish_list_model.g.dart';

/// Список данных по расписанию с днями выхода
@freezed
abstract class AnimeSchedulePublishListModel
    with _$AnimeSchedulePublishListModel {
  const factory AnimeSchedulePublishListModel({
    /// Список расписаний по дням выхода
    @JsonKey(name: 'publish_schedules')
    required List<AnimeSchedulePublishModel> publishSchedules,
  }) = _AnimeSchedulePublishListModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeSchedulePublishListModel.fromJson(Map<String, Object?> json) =>
      _$AnimeSchedulePublishListModelFromJson(json);
}
