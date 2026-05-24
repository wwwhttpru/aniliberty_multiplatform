import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_state.freezed.dart';

@freezed
sealed class ReleaseState with _$ReleaseState {
  const ReleaseState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory ReleaseState.idle() = _IdleReleaseState;

  /// Загрузка данных
  const factory ReleaseState.progress() = _ProgressReleaseState;

  /// Данные загружены
  const factory ReleaseState.success({
    required AnimeReleaseModel release,
  }) = _SuccessReleaseState;

  /// Не удалось загрузить данные
  const factory ReleaseState.error() = _ErrorReleaseState;
}
