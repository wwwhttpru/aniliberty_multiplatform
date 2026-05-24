import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

/// A reusable section widget with a title and a card containing children.
///
/// This widget displays a section with a title and a card containing
/// a list of child widgets. Commonly used for settings screens and
/// profile screens.
class SectionWidget extends StatelessWidget {
  /// The title of the section
  final String title;

  /// The list of widgets to display inside the card
  final List<Widget> children;

  /// Creates a [SectionWidget].
  ///
  /// The [title] and [children] parameters must not be null.
  const SectionWidget({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.spacingHOrSa,
    child: Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Padding(
          padding: const .directional(start: 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          removeRight: true,
          child: Card(
            margin: EdgeInsets.zero,
            child: Column(children: children),
            clipBehavior: Clip.antiAlias,
            shape: context.resolver.cardShape,
          ),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}
