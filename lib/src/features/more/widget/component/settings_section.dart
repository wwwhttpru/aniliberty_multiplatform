import 'package:aniliberty_multiplatform/src/features/more/widget/component/section_widget.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/scope/more_scope.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) => SectionWidget(
    title: 'Настройки',
    children: [
      ListTile(
        leading: const Icon(Icons.settings_outlined),
        title: const Text('Общие'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTapGeneral(context),
      ),
      ListTile(
        leading: const Icon(Icons.video_library_outlined),
        title: const Text('Видео'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTapVideo(context),
      ),
    ],
  );

  void _onTapGeneral(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openGeneralSettings();
  }

  void _onTapVideo(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openVideoSettings();
  }
}
