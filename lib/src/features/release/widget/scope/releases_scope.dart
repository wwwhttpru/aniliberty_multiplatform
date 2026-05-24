import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/release/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class ReleasesScope extends StatelessWidget {
  final Widget child;

  const ReleasesScope({required this.child, super.key});

  static ReleasesContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<ReleasesContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'ReleasesContainerOutputScope',
    );
  }

  static ReleaseContainerSM releaseContainerSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).releaseContainerSM;

  // TODO(wwwhttpru): remove by widget model
  static IReleasesNavigationInteractor navigationInteractorOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).navigationInteractor;

  static ReleasesSM releasesLatestSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).releasesLatestSM;

  static ReleasesSM releasesLatestAllSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).releasesLatestAllSM;

  static IReleasesLatestWM releasesLatestWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).releasesLatestWM;

  static IReleasesLatestAllWM releasesLatestAllWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).releasesLatestAllWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<ReleasesContainerOutputScope>(
        holder: AppScope.containerOf(context).releasesContainerHolder,
        child: ScopeBuilder<ReleasesContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
