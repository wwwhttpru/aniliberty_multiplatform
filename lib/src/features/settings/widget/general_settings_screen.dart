import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/common/list_radio_setting.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_language_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_theme_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/scope/settings_scope.dart';
import 'package:flutter/material.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Общие настройки')),
    body: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: context.spacingHOrSa,
          sliver: SliverToBoxAdapter(
            child: SettingThemeStateSelector(
              selector: (state) => state.value,
              builder: (context, state, child) => ListRadioSetting(
                title: 'Тема',
                icon: Icons.palette_outlined,
                items: AppThemeMode.values,
                selected: state,
                onChanged: (value) => _onThemeChanged(context, value),
                itemLabel: (value) => switch (value) {
                  AppThemeMode.light => 'Светлая',
                  AppThemeMode.dark => 'Тёмная',
                  AppThemeMode.system => 'Системная',
                },
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: context.spacingHOrSa.copyWith(top: 16),
          sliver: SliverToBoxAdapter(
            child: SettingLanguageStateSelector(
              selector: (state) => state.value,
              builder: (context, state, child) => ListRadioSetting(
                title: 'Язык',
                icon: Icons.language_outlined,
                items: AppLanguage.values,
                selected: state,
                onChanged: (value) => _onLanguageChanged(context, value),
                itemLabel: (value) => switch (value) {
                  AppLanguage.ru => 'Русский',
                  AppLanguage.en => 'Английский',
                },
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: context.spacingAllOrSa.copyWith(top: 0),
          sliver: const SliverToBoxAdapter(),
        ),
      ],
    ),
  );

  void _onThemeChanged(BuildContext context, AppThemeMode value) {
    final wm = SettingsScope.generalSettingsWMOf(
      context,
      listen: false,
    );
    return wm.setThemeMode(value);
  }

  void _onLanguageChanged(BuildContext context, AppLanguage value) {
    final wm = SettingsScope.generalSettingsWMOf(
      context,
      listen: false,
    );
    return wm.setLanguage(value);
  }
}
