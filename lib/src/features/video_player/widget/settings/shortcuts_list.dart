import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/service/video_shortcuts.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/settings/settings_section_title.dart';
import 'package:flutter/material.dart';

class ShortcutsList extends StatelessWidget {
  const ShortcutsList({super.key});

  @override
  Widget build(BuildContext context) => SettingsSectionTitle(
    title: 'Горячие клавиши',
    children: VideoShortcut.values
        .map(
          (shortcut) => _ShortcutItem(
            description: shortcut.descriptionOf(context),
            keyCombination: shortcut.labelOf(context),
          ),
        )
        .toList(growable: false),
  );
}

class _ShortcutItem extends StatelessWidget {
  /// The description of the shortcut
  final String description;

  /// The key combination of the shortcut
  final String keyCombination;

  const _ShortcutItem({
    required this.description,
    required this.keyCombination,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: context.resolver.cardBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              keyCombination,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
