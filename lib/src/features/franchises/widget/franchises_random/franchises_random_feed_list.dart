import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/feed/feed.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';

class FranchisesRandomFeedList extends StatefulWidget {
  const FranchisesRandomFeedList({super.key});

  @override
  State<FranchisesRandomFeedList> createState() =>
      _FranchisesRandomFeedListState();
}

class _FranchisesRandomFeedListState extends State<FranchisesRandomFeedList> {
  late final IFranchisesRandomWM _franchisesRandomWM;

  @override
  void initState() {
    super.initState();
    _franchisesRandomWM = FranchisesScope.franchisesRandomWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _franchisesRandomWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => FeedCategoryItem(
    title: 'Франшизы',
    subtitle: 'Самые интересные и захватывающие франшизы в любимой озвучке',
    onTap: _franchisesRandomWM.openAllFranchises,
    child: FranchisesRandomStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.map<Widget>(
          idle: (_) => const ProgressLayout(),
          progress: (_) => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeFranchises),
          error: (_) => ErrorLayout(onTap: _franchisesRandomWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeFranchisesModel animeFranchises;

  const _SuccessLayout(this.animeFranchises);

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemCount: animeFranchises.franchises.length,
    itemBuilder: (context, index) {
      final animeFranchise = animeFranchises.franchises[index];
      return FranchiseCardItem(animeFranchise: animeFranchise);
    },
  );
}

class _HorizontalListLayout extends StatelessWidget {
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const _HorizontalListLayout({
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: context.spacingH,
    itemCount: itemCount,
    itemBuilder: (context, index) {
      final child = itemBuilder(context, index);
      return SizedBox(width: 420, child: child);
    },
    separatorBuilder: (context, index) =>
        const SizedBox(width: FeedCategoryItem.hPadding),
  );
}
