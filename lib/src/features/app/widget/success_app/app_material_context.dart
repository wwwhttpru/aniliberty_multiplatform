import 'package:aniliberty_multiplatform/src/features/app/widget/success_app/app_theme_builder.dart';
import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppMaterialContext extends StatelessWidget {
  final RouterConfig<Object> routerConfig;
  final AppLanguage language;
  final AppThemeMode themeMode;

  const AppMaterialContext({
    required this.routerConfig,
    required this.language,
    required this.themeMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) => AppThemeBuilder(
    builder: (lightTheme, darkTheme) => MaterialApp.router(
      routerConfig: routerConfig,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme settings
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: switch (themeMode) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      },

      // TODO(wwwhttpru): add more languages
      locale: switch (language) {
        AppLanguage.en => const Locale('en'),
        AppLanguage.ru => const Locale('ru'),
      },
    ),
  );
}
