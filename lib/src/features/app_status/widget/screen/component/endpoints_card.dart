import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/screen/component/endpoint_item.dart';
import 'package:flutter/material.dart';

/// Card displaying available API endpoints.
class EndpointsCard extends StatelessWidget {
  /// List of endpoint URLs
  final List<String> endpoints;

  /// Creates an [EndpointsCard].
  const EndpointsCard({
    required this.endpoints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      shape: context.resolver.cardShape,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Icon(
                  Icons.api,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Доступные API endpoints',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (endpoints.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Нет доступных endpoints',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ...endpoints.asMap().entries.map(
              (entry) {
                final isLast = entry.key == endpoints.length - 1;
                return Column(
                  children: [
                    EndpointItem(endpoint: entry.value),
                    if (!isLast) const Divider(height: 1),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
