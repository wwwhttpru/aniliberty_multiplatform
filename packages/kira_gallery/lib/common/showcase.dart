import 'package:flutter/material.dart';
import 'package:kira_ui/kira_ui.dart';

/// Scrollable dark canvas for a foundation use-case.
class ShowcaseScaffold extends StatelessWidget {
  const ShowcaseScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.kiraColors.bg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

/// Uppercased mono section label (KIRA `Mono/MD` style).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        text.toUpperCase(),
        style: context.kiraText.monoMd.copyWith(
          color: context.kiraColors.textSecondary,
        ),
      ),
    );
  }
}

/// `#RRGGBB` of an opaque color (alpha dropped).
String hexOf(Color color) {
  final rgb = color.toARGB32() & 0xFFFFFF;
  return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
