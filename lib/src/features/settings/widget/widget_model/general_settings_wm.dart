import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template general_settings_wm}
/// Widget model for the general settings screen
/// {@endtemplate}
abstract interface class IGeneralSettingsWM {
  /// Set theme mode
  void setThemeMode(AppThemeMode themeMode);

  /// Set language
  void setLanguage(AppLanguage language);
}

/// {@macro general_settings_wm}
@immutable
class GeneralSettingsWM implements IGeneralSettingsWM {
  /// {@macro setting_theme_sm}
  final SettingThemeSM _themeModeSM;

  /// {@macro setting_language_sm}
  final SettingLanguageSM _languageSM;

  /// {@macro general_settings_wm}
  const GeneralSettingsWM({
    required this._themeModeSM,
    required this._languageSM,
  });

  @override
  void setThemeMode(AppThemeMode themeMode) {
    if (_themeModeSM.state.isProgress) {
      return;
    }

    _themeModeSM.createOrUpdate(themeMode);
  }

  @override
  void setLanguage(AppLanguage language) {
    if (_languageSM.state.isProgress) {
      return;
    }

    _languageSM.createOrUpdate(language);
  }
}
