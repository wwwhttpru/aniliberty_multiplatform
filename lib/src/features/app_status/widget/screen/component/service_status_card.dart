import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

/// Card displaying the service status.
class ServiceStatusCard extends StatelessWidget {
  /// Whether the service is alive
  final bool isAlive;

  /// Creates a [ServiceStatusCard].
  const ServiceStatusCard({
    required this.isAlive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      shape: context.resolver.cardShape,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAlive
                    ? colorScheme.primaryContainer
                    : colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isAlive ? Icons.check_circle : Icons.error,
                color: isAlive
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onErrorContainer,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Статус сервиса',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAlive ? 'Работает' : 'Недоступен',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isAlive ? colorScheme.primary : colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
