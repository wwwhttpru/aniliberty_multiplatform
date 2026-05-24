import 'package:aniliberty_multiplatform/src/core/widget/component/placeholder_image.dart';
import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  final VoidCallback onTap;

  const ErrorLayout({required this.onTap})
    : super(key: const ValueKey('ErrorLayout'));

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PlaceholderImage(height: 150, width: 150),
        Text(
          'Что-то пошло не так',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          'Попробуйте еще раз',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: onTap, child: const Text('Обновить')),
      ],
    ),
  );
}
