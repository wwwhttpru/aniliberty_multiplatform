import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/screen/component/request_info_row.dart';
import 'package:flutter/material.dart';

/// Card displaying request information.
class RequestInfoCard extends StatelessWidget {
  /// Request information model
  final AppStatusRequestModel request;

  /// Creates a [RequestInfoCard].
  const RequestInfoCard({
    required this.request,
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
                  Icons.info_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Информация о запросе',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          RequestInfoRow(
            icon: Icons.language,
            label: 'IP адрес',
            value: request.ip,
          ),
          const Divider(height: 1),
          RequestInfoRow(
            icon: Icons.public,
            label: 'Страна',
            value: request.country,
          ),
          const Divider(height: 1),
          RequestInfoRow(
            icon: Icons.flag,
            label: 'Код страны',
            value: request.isoCode,
          ),
          const Divider(height: 1),
          RequestInfoRow(
            icon: Icons.access_time,
            label: 'Часовой пояс',
            value: request.timezone,
          ),
        ],
      ),
    );
  }
}
