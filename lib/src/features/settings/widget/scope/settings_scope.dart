import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/settings/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/widget_model/general_settings_wm.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/widget_model/video_settings_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class SettingsScope extends StatelessWidget {
  final Widget child;

  const SettingsScope({
    required this.child,
    super.key,
  });

  static SettingsContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<SettingsContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'SettingsContainerOutputScope',
    );
  }

  static SettingThemeSM themeModeSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).themeModeSM;

  static SettingLanguageSM languageSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).languageSM;

  static SettingVideoQualitySM videoQualitySMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoQualitySM;

  static IGeneralSettingsWM generalSettingsWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).generalSettingsWM;

  static IVideoSettingsWM videoSettingsWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoSettingsWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<SettingsContainerOutputScope>(
        holder: AppScope.containerOf(context).settingsContainerHolder,
        child: ScopeBuilder<SettingsContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
