import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

/// An adaptive bottom sheet that automatically adjusts to different platforms and screen sizes.
///
/// This bottom sheet widget uses the app's adaptive system to provide optimal layout
/// and styling across mobile, tablet, desktop, and web platforms. It automatically
/// adjusts padding, spacing, and constraints based on the current screen size.
///
/// The bottom sheet consists of three main sections:
/// - **Title**: Displayed at the top with adaptive text styling
/// - **Content**: Scrollable content area that can expand to fill available space
/// - **Actions**: Action buttons displayed at the bottom
///
/// The sheet is draggable and can be dismissed by dragging down or tapping outside.
///
/// Example:
/// ```dart
/// AdaptiveSheet(
///   title: const Text('Settings'),
///   content: ListView(
///     children: [
///       ListTile(title: Text('Option 1')),
///       ListTile(title: Text('Option 2')),
///     ],
///   ),
///   actions: [
///     TextButton(
///       onPressed: () => Navigator.of(context).pop(),
///       child: const Text('Close'),
///     ),
///   ],
/// )
/// ```
class AdaptiveSheet extends StatelessWidget {
  /// The title widget displayed at the top of the bottom sheet.
  ///
  /// If you pass a [Text] widget, it will be automatically styled using
  /// the theme's `titleLarge` text style.
  final Widget title;

  /// The main content widget of the bottom sheet.
  ///
  /// This widget should handle its own scrolling if needed. It's recommended
  /// to use a [ListView] or [SingleChildScrollView] for scrollable content.
  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
  )
  builder;

  /// The initial size of the bottom sheet as a fraction of the screen height.
  ///
  /// Defaults to 0.7 (70% of screen height).
  final double initialChildSize;

  /// The minimum size of the bottom sheet as a fraction of the screen height.
  ///
  /// Defaults to 0.5 (50% of screen height).
  final double minChildSize;

  /// The maximum size of the bottom sheet as a fraction of the screen height.
  ///
  /// Defaults to 0.95 (95% of screen height).
  final double maxChildSize;

  /// Creates an adaptive bottom sheet.
  ///
  /// The [title] and [builder] parameters are required.
  const AdaptiveSheet({
    required this.title,
    required this.builder,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.95,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          // Title
          Padding(
            padding: context.spacingH,
            child: DefaultTextStyle(
              style: theme.textTheme.titleLarge ?? const TextStyle(),
              child: title,
              textAlign: TextAlign.center,
            ),
          ),
          builder(context, scrollController),
        ],
      ),
    );
  }
}
