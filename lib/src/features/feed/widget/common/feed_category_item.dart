import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

class FeedCategoryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget child;

  const FeedCategoryItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.child,
    super.key,
  });

  static const double hPadding = 12;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: context.spacingH,
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [_Title(title), _Subtitle(subtitle)],
                ),
              ),
              _Button(onTap: onTap),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(height: 260, child: child),
      ],
    ),
  );
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 1,
    textAlign: TextAlign.left,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.titleMedium,
  );
}

class _Subtitle extends StatelessWidget {
  final String text;

  const _Subtitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 2,
    textAlign: TextAlign.left,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.bodyMedium,
  );
}

class _Button extends StatelessWidget {
  final VoidCallback onTap;

  const _Button({required this.onTap});

  @override
  Widget build(BuildContext context) => FloatingActionButton.small(
    elevation: 0,
    child: const Icon(Icons.chevron_right),
    heroTag: null,
    onPressed: onTap,
  );
}
