/// {@template app_theme_mode}
/// Theme mode enum for app appearance
/// {@endtemplate}
enum AppThemeMode {
  /// Light theme
  light('light'),

  /// Dark theme
  dark('dark'),

  /// System theme (follows device settings)
  system('system')
  ;

  /// {@macro app_theme_mode}
  const AppThemeMode(this.code);

  /// Code of the theme mode
  final String code;
}
