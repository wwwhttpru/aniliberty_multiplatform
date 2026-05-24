import 'package:aniliberty_multiplatform/src/features/franchises/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class FranchiseScope extends StatelessWidget {
  final String franchiseId;
  final Widget child;

  const FranchiseScope({
    required this.franchiseId,
    required this.child,
    super.key,
  });

  static FranchiseContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<FranchiseContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'FranchiseContainerOutputScope',
    );
  }

  static FranchiseSM franchiseSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchiseSM;

  static IFranchiseWM franchiseWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchiseWM;

  @override
  Widget build(BuildContext context) => FranchiseContainerStateBuilder(
    franchiseId: franchiseId,
    child: child,
  );
}
