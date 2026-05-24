import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FranchisesAllScreen extends StatefulWidget {
  const FranchisesAllScreen({super.key});

  @override
  State<FranchisesAllScreen> createState() => _FranchisesAllScreenState();
}

class _FranchisesAllScreenState extends State<FranchisesAllScreen> {
  late final IFranchisesAllWM _franchisesAllWM;

  @override
  void initState() {
    super.initState();
    _franchisesAllWM = FranchisesScope.franchisesAllWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _franchisesAllWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FranchisesAllStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeFranchises),
          error: (_) => ErrorLayout(onTap: _franchisesAllWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeFranchisesModel animeFranchises;

  const _SuccessLayout(this.animeFranchises);

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
          child: Text(
            'Франшизы',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverPadding(
        padding: context.spacingH,
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 420,
            childAspectRatio: 420 / 200, // 420 - width, 200 - height
            mainAxisExtent: 200,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final animeFranchise = animeFranchises.franchises[index];
            return FranchiseCardItem(
              key: ValueKey(animeFranchise.id),
              animeFranchise: animeFranchise,
            );
          },
          itemCount: animeFranchises.franchises.length,
        ),
      ),
      SliverPadding(
        padding: context.spacingAll.copyWith(top: 16),
        sliver: const SliverToBoxAdapter(),
      ),
    ],
  );
}
