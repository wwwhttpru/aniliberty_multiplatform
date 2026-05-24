import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:flutter/material.dart';

class RailThemeButton extends StatelessWidget {
  const RailThemeButton({super.key});

  @override
  Widget build(BuildContext context) => SettingThemeStateSelector(
    selector: (state) => state.value,
    builder: (context, state, child) => IconButton.outlined(
      onPressed: () => _onPressed(context, state),
      style: IconButton.styleFrom(fixedSize: const .square(56)),
      icon: Icon(
        switch (state) {
          AppThemeMode.light => Icons.light_mode,
          AppThemeMode.dark => Icons.dark_mode,
          AppThemeMode.system => Icons.brightness_auto,
        },
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        size: 24,
      ),
    ),
  );

  void _onPressed(BuildContext context, AppThemeMode themeMode) {
    final wm = SettingsScope.generalSettingsWMOf(
      context,
      listen: false,
    );

    final brightness = Theme.of(context).brightness;
    final next = switch (themeMode) {
      AppThemeMode.light => AppThemeMode.dark,
      AppThemeMode.dark => AppThemeMode.light,
      AppThemeMode.system => switch (brightness) {
        Brightness.light => AppThemeMode.dark,
        Brightness.dark => AppThemeMode.light,
      },
    };

    return wm.setThemeMode(next);
  }
}
