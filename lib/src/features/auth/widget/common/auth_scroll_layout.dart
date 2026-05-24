import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

/// {@template auth_scroll_layout}
/// Layout for authentication screens with scrollable content
/// {@endtemplate}
class AuthScrollLayout extends StatelessWidget {
  final Widget child;

  /// {@macro auth_scroll_layout}
  const AuthScrollLayout({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final padding = context.spacingAllOrSa;
      final minHeight = constraints.maxHeight - padding.vertical;
      return SingleChildScrollView(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: child,
            ),
          ),
        ),
      );
    },
  );
}
