import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_week_state.freezed.dart';

@freezed
sealed class ScheduleWeekState with _$ScheduleWeekState {
  const ScheduleWeekState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory ScheduleWeekState.idle() = _IdleScheduleWeekState;

  /// Загрузка данных
  const factory ScheduleWeekState.progress() = _ProgressScheduleWeekState;

  /// Данные загружены
  const factory ScheduleWeekState.success({
    required AnimeSchedulePublishListModel animeScheduleWeek,
  }) = _SuccessScheduleWeekState;

  /// Не удалось загрузить данные
  const factory ScheduleWeekState.error() = _ErrorScheduleWeekState;
}
