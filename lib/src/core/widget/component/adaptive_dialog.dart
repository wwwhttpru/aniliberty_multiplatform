import 'dart:math' as math;

import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

/// An adaptive dialog that automatically adjusts to different platforms and screen sizes.
///
/// This dialog widget uses the app's adaptive system to provide optimal layout
/// and styling across mobile, tablet, desktop, and web platforms. It automatically
/// adjusts padding, spacing, and constraints based on the current screen size.
///
/// The dialog consists of three main sections:
/// - **Title**: Displayed at the top with adaptive text styling
/// - **Content**: Flexible content area that can scroll if needed
/// - **Actions**: Action buttons displayed at the bottom
///
/// Example:
/// ```dart
/// AdaptiveDialog(
///   title: const Text('Confirm Action'),
///   content: const Text('Are you sure you want to proceed?'),
///   actions: [
///     TextButton(
///       onPressed: () => Navigator.of(context).pop(false),
///       child: const Text('Cancel'),
///     ),
///     TextButton(
///       onPressed: () => Navigator.of(context).pop(true),
///       child: const Text('Confirm'),
///     ),
///   ],
/// )
/// ```
class AdaptiveDialog extends StatelessWidget {
  /// The title widget displayed at the top of the dialog.
  ///
  /// If you pass a [Text] widget, it will be automatically styled using
  /// the theme's `titleLarge` text style.
  final Widget title;

  /// The main content widget of the dialog.
  ///
  /// This widget is wrapped in a [Flexible] widget to take up all available
  /// space between the title and actions. If the content exceeds the available
  /// height, it should handle scrolling internally.
  final Widget content;

  /// The list of action widgets displayed at the bottom of the dialog.
  ///
  /// These widgets are arranged horizontally in an [OverflowBar] and aligned
  /// to the end (right side) of the dialog. Common actions include buttons
  /// like "Cancel", "OK", "Confirm", etc.
  ///
  /// Defaults to an empty list if not provided.
  final List<Widget> actions;

  /// Creates an adaptive dialog.
  ///
  /// The [title] and [content] parameters are required.
  /// The [actions] parameter defaults to an empty list.
  const AdaptiveDialog({
    required this.title,
    required this.content,
    this.actions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolver = context.resolver;
    return LayoutBuilder(
      builder: (context, constraints) => Dialog(
        shape: resolver.cardShape,
        constraints: BoxConstraints(
          maxWidth: _maxWidth(constraints, context),
          maxHeight: _maxHeight(constraints, context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Padding(
              padding: context.spacingAll.copyWith(bottom: 0),
              child: DefaultTextStyle(
                style: theme.textTheme.titleLarge ?? const TextStyle(),
                child: title,
              ),
            ),
            content,
            Padding(
              padding: context.spacingAll.copyWith(top: 0),
              child: OverflowBar(
                spacing: 8,
                children: actions,
                alignment: MainAxisAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Calculates the maximum width of the dialog.
  ///
  /// The width is constrained to a maximum of 600 pixels, taking into account
  /// the available screen space and adaptive padding.
  ///
  /// Returns the calculated maximum width in logical pixels.
  double _maxWidth(BoxConstraints constraints, BuildContext context) {
    final padding = context.spacingAll;
    final value = math.min(constraints.maxWidth, constraints.maxHeight);
    return math.min(600, value - padding.horizontal).toDouble();
  }

  /// Calculates the maximum height of the dialog.
  ///
  /// The height is set to 80% of the available screen height, minus the
  /// vertical padding to ensure proper spacing from screen edges.
  ///
  /// Returns the calculated maximum height in logical pixels.
  double _maxHeight(BoxConstraints constraints, BuildContext context) {
    final padding = context.spacingAll;
    final value = constraints.maxHeight * 0.8 - padding.vertical;
    return value;
  }
}
