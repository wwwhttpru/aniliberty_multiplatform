import 'package:aniliberty_multiplatform/src/features/settings/domain/entity/theme_mode.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/repository/settings_repository.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/state_manager/setting_value_sm.dart';

class _SettingThemeUseCase implements ISettingValueUseCase<AppThemeMode> {
  final ISettingsRepository _repository;

  @override
  AppThemeMode get defaultValue => AppThemeMode.system;

  _SettingThemeUseCase({
    required this._repository,
  });

  @override
  Future<void> createOrUpdate(
    AppThemeMode value,
  ) => _repository.writeThemeMode(value);

  @override
  Future<AppThemeMode> read() => _repository.readThemeMode();
}

/// {@template setting_theme_sm}
/// State manager for theme mode setting
/// {@endtemplate}
final class SettingThemeSM extends SettingValueSM<AppThemeMode> {
  /// {@macro setting_theme_sm}
  SettingThemeSM({
    required ISettingsRepository repository,
  }) : super(useCase: _SettingThemeUseCase(repository: repository));
}
