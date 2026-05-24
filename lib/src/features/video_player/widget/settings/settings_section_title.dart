import 'package:flutter/material.dart';

class SettingsSectionTitle extends StatelessWidget {
  /// Title of the section
  final String title;

  /// Children of the section
  ///
  /// Use this to add more widgets to the section
  final List<Widget> children;

  const SettingsSectionTitle({
    required this.title,
    this.children = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w400,
          ),
        ),
        ...children,
      ],
    );
  }
}
