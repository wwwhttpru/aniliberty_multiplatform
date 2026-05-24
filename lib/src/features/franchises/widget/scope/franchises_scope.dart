import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class FranchisesScope extends StatelessWidget {
  final Widget child;

  const FranchisesScope({required this.child, super.key});

  static FranchisesContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<FranchisesContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'FranchisesContainerOutputScope',
    );
  }

  static FranchiseContainerSM franchiseContainerSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchiseContainerSM;

  static IFranchisesNavigationInteractor navigationInteractorOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).navigationInteractor;

  static FranchisesSM franchisesAllSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchisesAllSM;

  static FranchisesSM franchisesRandomSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchisesRandomSM;

  static IFranchisesAllWM franchisesAllWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchisesAllWM;

  static IFranchisesRandomWM franchisesRandomWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).franchisesRandomWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<FranchisesContainerOutputScope>(
        holder: AppScope.containerOf(context).franchisesContainerHolder,
        child: ScopeBuilder<FranchisesContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
