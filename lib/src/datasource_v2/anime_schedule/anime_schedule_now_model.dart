import 'package:aniliberty_multiplatform/src/datasource_v2/anime_schedule/anime_schedule_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_schedule_now_model.freezed.dart';
part 'anime_schedule_now_model.g.dart';

/// Данные по релизам в расписании
@freezed
abstract class AnimeScheduleNowModel with _$AnimeScheduleNowModel {
  const factory AnimeScheduleNowModel({
    /// Сегодня
    @JsonKey(name: 'today') required List<AnimeScheduleModel> today,

    /// Завтра
    @JsonKey(name: 'tomorrow') required List<AnimeScheduleModel> tomorrow,

    /// Вчера
    @JsonKey(name: 'yesterday') required List<AnimeScheduleModel> yesterday,
  }) = _AnimeScheduleNowModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeScheduleNowModel.fromJson(Map<String, Object?> json) =>
      _$AnimeScheduleNowModelFromJson(json);
}
