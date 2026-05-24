import 'package:aniliberty_multiplatform/src/features/settings/domain/entity/app_language.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/repository/settings_repository.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/state_manager/setting_value_sm.dart';

class _SettingLanguageUseCase implements ISettingValueUseCase<AppLanguage> {
  final ISettingsRepository _repository;

  @override
  AppLanguage get defaultValue => AppLanguage.en;

  _SettingLanguageUseCase({
    required this._repository,
  });

  @override
  Future<void> createOrUpdate(
    AppLanguage value,
  ) => _repository.writeLanguage(value);

  @override
  Future<AppLanguage> read() => _repository.readLanguage();
}

/// {@template setting_language_sm}
/// State manager for language setting
/// {@endtemplate}
final class SettingLanguageSM extends SettingValueSM<AppLanguage> {
  /// {@macro setting_language_sm}
  SettingLanguageSM({
    required ISettingsRepository repository,
  }) : super(useCase: _SettingLanguageUseCase(repository: repository));
}
