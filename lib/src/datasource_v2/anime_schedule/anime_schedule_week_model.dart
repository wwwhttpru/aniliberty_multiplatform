import 'package:aniliberty_multiplatform/src/datasource_v2/anime_schedule/anime_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_schedule_week_model.freezed.dart';
part 'anime_schedule_week_model.g.dart';

@freezed
abstract class AnimeScheduleWeekModel with _$AnimeScheduleWeekModel {
  const factory AnimeScheduleWeekModel({
    /// Список данных по релизу
    @JsonKey(name: 'schedules') required List<AnimeScheduleModel> schedules,
  }) = _AnimeScheduleWeekModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeScheduleWeekModel.fromJson(Map<String, Object?> json) =>
      _$AnimeScheduleWeekModelFromJson(json);
}
