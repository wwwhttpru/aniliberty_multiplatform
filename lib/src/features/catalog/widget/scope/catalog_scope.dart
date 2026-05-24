import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

/// Scope widget for catalog feature.
///
/// Provides access to catalog dependencies through the widget tree.
class CatalogScope extends StatelessWidget {
  /// Child widget to be wrapped with the scope
  final Widget child;

  /// Creates a new instance of [CatalogScope].
  ///
  /// [child] - The child widget to be wrapped with the scope
  const CatalogScope({
    required this.child,
    super.key,
  });

  static CatalogContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<CatalogContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'CatalogContainerOutputScope',
    );
  }

  static CatalogReleaseSM catalogReleaseSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).catalogReleaseSM;

  static CatalogReferencesSM catalogReferencesSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).catalogReferencesSM;

  static CatalogFilterSM catalogFilterSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).catalogFilterSM;

  static ICatalogReleaseWM catalogReleaseWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).catalogReleaseWM;

  static ICatalogFilterWM catalogFilterWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).catalogFilterWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<CatalogContainerOutputScope>(
        holder: AppScope.containerOf(context).catalogContainerHolder,
        child: ScopeBuilder<CatalogContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
