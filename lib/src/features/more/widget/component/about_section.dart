import 'package:aniliberty_multiplatform/src/features/more/widget/component/section_widget.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/scope/more_scope.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) => SectionWidget(
    title: 'О приложении',
    children: [
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('Статус API'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTapAppStatus(context),
      ),
      ListTile(
        leading: const Icon(Icons.help_outline),
        title: const Text('Помощь'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTapHelp(context),
      ),
      ListTile(
        leading: const Icon(Icons.bug_report_outlined),
        title: const Text('Сообщить об ошибке'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTapBugReport(context),
      ),
    ],
  );

  void _onTapAppStatus(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openAppStatus();
  }

  void _onTapHelp(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openHelp();
  }

  void _onTapBugReport(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openBugReport();
  }
}
