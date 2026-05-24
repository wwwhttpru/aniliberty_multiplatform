/// {@template app_language}
/// App language enum
/// {@endtemplate}
enum AppLanguage {
  /// Russian
  ru('ru'),

  /// English
  en('en')
  ;

  /// {@macro app_language}
  const AppLanguage(this.code);

  /// Code of the language
  final String code;
}
