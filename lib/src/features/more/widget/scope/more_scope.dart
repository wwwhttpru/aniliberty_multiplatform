import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/more/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/widget_model/more_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class MoreScope extends StatelessWidget {
  final Widget child;

  const MoreScope({
    required this.child,
    super.key,
  });

  static MoreContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<MoreContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(container, 'MoreContainerOutputScope');
  }

  static IMoreWM wmOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).moreWM;

  @override
  Widget build(BuildContext context) => ScopeProvider<MoreContainerOutputScope>(
    holder: AppScope.containerOf(context).moreContainerHolder,
    child: ScopeBuilder<MoreContainerOutputScope>.withPlaceholder(
      placeholder: const ProgressLayout(),
      builder: (context, scope) => child,
    ),
  );
}
