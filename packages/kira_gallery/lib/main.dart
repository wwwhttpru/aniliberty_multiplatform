import 'package:flutter/material.dart';
import 'package:kira_gallery/main.directories.g.dart';
import 'package:kira_ui/kira_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() => runApp(const KiraGallery());

@widgetbook.App()
class KiraGallery extends StatelessWidget {
  const KiraGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'KIRA', data: buildKiraTheme()),
          ],
        ),
      ],
    );
  }
}
