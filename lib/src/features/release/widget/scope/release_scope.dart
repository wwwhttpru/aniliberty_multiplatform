import 'package:aniliberty_multiplatform/src/features/release/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class ReleaseScope extends StatelessWidget {
  final String aliasOrId;
  final Widget child;

  const ReleaseScope({required this.aliasOrId, required this.child, super.key});

  static ReleaseContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<ReleaseContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'ReleaseContainerOutputScope',
    );
  }

  static ReleaseSM releaseSMOf(BuildContext context, {bool listen = true}) =>
      containerOf(context, listen: listen).releaseSM;

  static IReleaseWM releaseWMOf(BuildContext context, {bool listen = true}) =>
      containerOf(context, listen: listen).releaseWM;

  @override
  Widget build(BuildContext context) =>
      ReleaseContainerStateBuilder(aliasOrId: aliasOrId, child: child);
}
