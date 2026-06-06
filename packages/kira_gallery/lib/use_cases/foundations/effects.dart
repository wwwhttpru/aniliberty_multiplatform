import 'package:flutter/material.dart';
import 'package:kira_gallery/common/showcase.dart';
import 'package:kira_ui/kira_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Effects', type: KiraEffects, path: 'Foundations')
Widget buildEffectsUseCase(BuildContext context) {
  final e = context.kiraEffects;
  final colors = context.kiraColors;

  final glows = <(String, List<BoxShadow>)>[
    ('Glow / Magenta', e.glowMagenta),
    ('Glow / Magenta Strong', e.glowMagentaStrong),
    ('Glow / Cyan', e.glowCyan),
    ('Glow / Gold', e.glowGold),
  ];
  final elevations = <(String, List<BoxShadow>)>[
    ('Elevation / Card', e.elevationCard),
    ('Elevation / Float', e.elevationFloat),
    ('Elevation / Overlay', e.elevationOverlay),
  ];

  Widget tile(String name, List<BoxShadow> shadow) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: colors.surfaceRaised,
            borderRadius: BorderRadius.circular(
              context.kiraDimensions.radiusLg,
            ),
            border: Border.all(color: colors.border),
            boxShadow: shadow,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: context.kiraText.monoSm.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }

  return ShowcaseScaffold(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Neon glows'),
        Wrap(
          spacing: 44,
          runSpacing: 44,
          children: [for (final (name, shadow) in glows) tile(name, shadow)],
        ),
        const SectionLabel('Elevation'),
        Wrap(
          spacing: 44,
          runSpacing: 44,
          children: [
            for (final (name, shadow) in elevations) tile(name, shadow),
          ],
        ),
      ],
    ),
  );
}
