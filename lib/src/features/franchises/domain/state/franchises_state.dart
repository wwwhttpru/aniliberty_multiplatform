import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchises_state.freezed.dart';

@freezed
sealed class FranchisesState with _$FranchisesState {
  const FranchisesState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory FranchisesState.idle() = _IdleFranchisesState;

  /// Загрузка данных
  const factory FranchisesState.progress() = _ProgressFranchisesState;

  /// Данные загружены
  const factory FranchisesState.success({
    required AnimeFranchisesModel animeFranchises,
  }) = _SuccessFranchisesState;

  /// Не удалось загрузить данные
  const factory FranchisesState.error() = _ErrorFranchisesState;
}
