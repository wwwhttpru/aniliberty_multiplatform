import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final AppContainerHolder appContainerHolder;

  const App({required this.appContainerHolder, super.key});

  @override
  Widget build(BuildContext context) => AdaptiveScope(
    child: AppScope(
      appContainerHolder: appContainerHolder,

      // TODO(wwwhttpru): move to router
      child: const AuthScope(
        child: SettingsScope(
          child: VideoContentScope(
            child: SearchScope(
              child: ReleasesScope(
                child: AppUi(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class AppUi extends StatelessWidget {
  const AppUi({super.key});

  @override
  Widget build(BuildContext context) => SettingLanguageStateSelector(
    selector: (state) => state.value,
    builder: (context, language, child) => SettingThemeStateSelector(
      selector: (state) => state.value,
      builder: (context, themeMode, child) => AppMaterialContext(
        routerConfig: AppScope.navigationScopeOf(context).routerConfig,
        language: language,
        themeMode: themeMode,
      ),
    ),
  );
}
