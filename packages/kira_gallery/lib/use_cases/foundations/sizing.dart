import 'package:flutter/material.dart';
import 'package:kira_gallery/common/showcase.dart';
import 'package:kira_ui/kira_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Sizing', type: KiraDimensions, path: 'Foundations')
Widget buildSizingUseCase(BuildContext context) {
  final d = context.kiraDimensions;
  final colors = context.kiraColors;

  final spacing = <(String, double)>[
    ('2xs', d.space2xs),
    ('xs', d.spaceXs),
    ('sm', d.spaceSm),
    ('md', d.spaceMd),
    ('lg', d.spaceLg),
    ('xl', d.spaceXl),
    ('2xl', d.space2xl),
    ('3xl', d.space3xl),
  ];
  final radii = <(String, double)>[
    ('xs', d.radiusXs),
    ('sm', d.radiusSm),
    ('md', d.radiusMd),
    ('lg', d.radiusLg),
    ('xl', d.radiusXl),
    ('2xl', d.radius2xl),
    ('3xl', d.radius3xl),
  ];

  return ShowcaseScaffold(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Spacing'),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            for (final (name, value) in spacing)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: value,
                    height: value,
                    color: colors.accent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$name · ${value.toInt()}',
                    style: context.kiraText.monoSm.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SectionLabel('Radius'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final (name, value) in radii)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: colors.surfaceOverlay,
                      borderRadius: BorderRadius.circular(value),
                      border: Border.all(color: colors.borderStrong),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$name · ${value.toInt()}',
                    style: context.kiraText.monoSm.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}
