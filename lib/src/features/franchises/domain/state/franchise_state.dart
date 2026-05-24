import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise_state.freezed.dart';

@freezed
sealed class FranchiseState with _$FranchiseState {
  const FranchiseState._();

  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Ожидание действий от пользователя
  const factory FranchiseState.idle() = _IdleFranchiseState;

  /// Загрузка данных
  const factory FranchiseState.progress() = _ProgressFranchiseState;

  /// Данные загружены
  const factory FranchiseState.success({
    required AnimeFranchiseModel animeFranchise,
  }) = _SuccessFranchiseState;

  /// Не удалось загрузить данные
  const factory FranchiseState.error() = _ErrorFranchiseState;
}
