import 'package:aniliberty_multiplatform/src/features/settings/domain/state/setting_value_state.dart';
import 'package:yx_state/yx_state.dart';

/// Use case for a setting value
abstract interface class ISettingValueUseCase<T> {
  /// The default value
  T get defaultValue;

  /// Creates or updates the value
  Future<void> createOrUpdate(T value);

  /// Reads the value
  Future<T> read();
}

/// {@template setting_value_sm}
/// State manager for a setting value
/// {@endtemplate}
base class SettingValueSM<T> extends StateManager<SettingValueState<T>> {
  /// The use case for the setting value
  final ISettingValueUseCase<T> _useCase;

  /// {@macro setting_value_sm}
  SettingValueSM({
    required ISettingValueUseCase<T> useCase,
  }) : _useCase = useCase,
       super(SettingValueState.idle(value: useCase.defaultValue));

  /// Initializes the state manager
  Future<void> init() async => read();

  /// Reads the value
  void read() => handle(
    (emit) async {
      emit(SettingValueState<T>.progress(value: state.value));
      try {
        final value = await _useCase.read();
        emit(SettingValueState<T>.success(value: value));
      } on Object catch (error, stackTrace) {
        emit(SettingValueState<T>.error(value: state.value));
        addError(error, stackTrace);
      } finally {
        emit(SettingValueState<T>.idle(value: state.value));
      }
    },
    identifier: 'read',
  );

  /// Creates or updates the value
  void createOrUpdate(T value) => handle(
    (emit) async {
      final previousValue = state.value;
      emit(SettingValueState<T>.progress(value: value));
      try {
        await _useCase.createOrUpdate(value);
        emit(SettingValueState<T>.success(value: value));
      } on Object catch (error, stackTrace) {
        emit(SettingValueState<T>.error(value: previousValue));
        addError(error, stackTrace);
      } finally {
        emit(SettingValueState<T>.idle(value: state.value));
      }
    },
  );
}
