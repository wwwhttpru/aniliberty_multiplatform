import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'releases_state.freezed.dart';

@freezed
sealed class ReleasesState with _$ReleasesState {
  const ReleasesState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory ReleasesState.idle() = _IdleReleasesState;

  /// Загрузка данных
  const factory ReleasesState.progress() = _ProgressReleasesState;

  /// Данные загружены
  const factory ReleasesState.success({
    required AnimeReleasesModel releases,
  }) = _SuccessReleasesState;

  /// Не удалось загрузить данные
  const factory ReleasesState.error() = _ErrorReleasesState;
}
