import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

class GenreGridProgressItem extends StatelessWidget {
  const GenreGridProgressItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Shimmer(
      background: colorScheme.surface,
      highlight: colorScheme.surfaceContainerHigh,
      speed: 0.5,
      stripe: 0.75,
      radius: context.resolver.shimmerRadius,
    );
  }
}
