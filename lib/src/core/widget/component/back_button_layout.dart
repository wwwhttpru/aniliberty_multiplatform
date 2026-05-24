import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

class BackButtonLayout extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButtonLayout({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(right: 4, top: 16, bottom: 16),
          foregroundColor: colorScheme.onSurface,
          textStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          iconColor: colorScheme.onSurface,
          iconSize: context.resolver.adaptive(
            compact: 16,
            expanded: 18,
            large: 20,
          ),
          minimumSize: Size.zero,
          shape: context.resolver.buttonShape,
        ),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        label: const Text('Назад'),
      ),
    );
  }
}
