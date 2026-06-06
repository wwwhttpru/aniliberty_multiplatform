import 'package:flutter/material.dart';
import 'package:kira_gallery/common/showcase.dart';
import 'package:kira_ui/kira_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Typography',
  type: KiraTypography,
  path: 'Foundations',
)
Widget buildTypographyUseCase(BuildContext context) {
  final t = context.kiraText;

  // Samples mix Cyrillic + Latin to verify the display Cyrillic fallback
  // (Space Grotesk → Onest) and that body/mono carry Cyrillic.
  final rows = <(String, TextStyle, String)>[
    ('Display/2XL', t.display2xl, 'Аниме Anime'),
    ('Display/XL', t.displayXl, 'Аниме без шума'),
    ('Display/LG', t.displayLg, 'Новые эпизоды'),
    ('Display/MD', t.displayMd, 'Расписание релизов'),
    ('Title/LG', t.titleLg, 'Продолжить смотреть'),
    ('Title/MD', t.titleMd, 'Последние видео'),
    ('Body/LG', t.bodyLg, 'Смотреть онлайн в хорошем качестве — Anime 123'),
    ('Body/MD', t.bodyMd, 'Тёмная дизайн-система для стриминга — Body 123'),
    ('Body/SM', t.bodySm, 'Дополнительное описание мелким текстом'),
    ('Label/Button', t.labelButton, 'Смотреть'),
    ('Label/Small', t.labelSmall, 'Подписка активна'),
    ('Mono/MD', t.monoMd, 'Эфир · Live'),
    ('Mono/SM', t.monoSm, 'Сезон 2 · S2'),
    ('Mono/XS', t.monoXs, 'Ep 12'),
    ('Numeric', t.numeric, '1 250'),
  ];

  return ShowcaseScaffold(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (name, style, sample) in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: t.monoSm.copyWith(
                    color: context.kiraColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(sample, style: style),
              ],
            ),
          ),
      ],
    ),
  );
}
