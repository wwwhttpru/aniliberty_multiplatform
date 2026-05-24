import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/state/franchise_state.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/franchise/franchise_info_layout.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/franchise/franchise_release_info_layout.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FranchiseScreen extends StatefulWidget {
  const FranchiseScreen({super.key});

  @override
  State<FranchiseScreen> createState() => _FranchiseScreenState();
}

class _FranchiseScreenState extends State<FranchiseScreen> {
  late final IFranchiseWM _franchiseWM;

  @override
  void initState() {
    super.initState();
    _franchiseWM = FranchiseScope.franchiseWMOf(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _franchiseWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FranchiseStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeFranchise),
          error: (_) => ErrorLayout(onTap: _franchiseWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeFranchiseModel animeFranchise;

  const _SuccessLayout(this.animeFranchise);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    slivers: [
      SliverPadding(
        padding: context.spacingAll.copyWith(bottom: 16),
        sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
      ),
      SliverPadding(
        padding: context.spacingH.copyWith(bottom: 16),
        sliver: SliverToBoxAdapter(
          child: FranchiseInfoLayout(animeFranchise: animeFranchise),
        ),
      ),
      SliverPadding(
        padding: context.spacingH,
        sliver: SliverList.separated(
          itemCount: animeFranchise.franchiseReleases?.length ?? 0,
          itemBuilder: (context, index) {
            final values = animeFranchise.franchiseReleases ?? const [];
            final value = values[index];
            return FranchiseReleaseInfoLayout(
              key: ValueKey(value.release.alias),
              animeFranchiseRelease: value,
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      SliverPadding(
        padding: context.spacingAll.copyWith(top: 16),
        sliver: const SliverToBoxAdapter(),
      ),
    ],
  );
}
