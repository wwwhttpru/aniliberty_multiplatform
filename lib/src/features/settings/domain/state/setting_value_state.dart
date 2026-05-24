import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_value_state.freezed.dart';

@freezed
sealed class SettingValueState<T> with _$SettingValueState<T> {
  const SettingValueState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (settings loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (settings loading failed)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  const factory SettingValueState.idle({
    required T value,
  }) = IdleSettingValueState<T>;

  const factory SettingValueState.progress({
    required T value,
  }) = ProgressSettingValueState<T>;

  const factory SettingValueState.success({
    required T value,
  }) = SuccessSettingValueState<T>;

  const factory SettingValueState.error({
    required T value,
  }) = ErrorSettingValueState<T>;
}
