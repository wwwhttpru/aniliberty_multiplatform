import 'package:flutter/material.dart';
import 'package:kira_gallery/common/showcase.dart';
import 'package:kira_ui/kira_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Colors', type: KiraColors, path: 'Foundations')
Widget buildColorsUseCase(BuildContext context) {
  final c = context.kiraColors;
  final semantic = <(String, Color)>[
    ('bg', c.bg),
    ('surface', c.surface),
    ('surface-raised', c.surfaceRaised),
    ('surface-overlay', c.surfaceOverlay),
    ('surface-hover', c.surfaceHover),
    ('text', c.text),
    ('text-secondary', c.textSecondary),
    ('text-muted', c.textMuted),
    ('text-inverse', c.textInverse),
    ('accent', c.accent),
    ('accent-soft', c.accentSoft),
    ('accent-hover', c.accentHover),
    ('accent-pressed', c.accentPressed),
    ('on-accent', c.onAccent),
    ('cyan', c.cyan),
    ('cyan-hover', c.cyanHover),
    ('gold', c.gold),
    ('success', c.success),
    ('warning', c.warning),
    ('danger', c.danger),
    ('border', c.border),
    ('border-strong', c.borderStrong),
    ('scrim', c.scrim),
    ('overlay-soft', c.overlaySoft),
  ];

  return ShowcaseScaffold(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Signature gradient'),
        Container(
          height: 72,
          decoration: BoxDecoration(
            gradient: context.kiraGradients.accent,
            borderRadius: BorderRadius.circular(
              context.kiraDimensions.radiusLg,
            ),
          ),
        ),
        const SectionLabel('Semantic colors'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final (label, color) in semantic) _Swatch(label, color),
          ],
        ),
      ],
    ),
  );
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                context.kiraDimensions.radiusSm,
              ),
              border: Border.all(color: context.kiraColors.border),
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: context.kiraText.labelSmall),
          Text(
            hexOf(color),
            style: context.kiraText.monoSm.copyWith(
              color: context.kiraColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
