import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_now_state.freezed.dart';

@freezed
sealed class ScheduleNowState with _$ScheduleNowState {
  const ScheduleNowState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory ScheduleNowState.idle() = _IdleScheduleNowState;

  /// Загрузка данных
  const factory ScheduleNowState.progress() = _ProgressScheduleNowState;

  /// Данные загружены
  const factory ScheduleNowState.success({
    required AnimeScheduleNowModel animeScheduleNow,
  }) = _SuccessScheduleNowState;

  /// Не удалось загрузить данные
  const factory ScheduleNowState.error() = _ErrorScheduleNowState;
}
