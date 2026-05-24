import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/franchises.dart';
import 'package:aniliberty_multiplatform/src/features/genres/genres.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/promotions.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/schedule.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/video_content.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        const SliverAppBar(title: Text('Главная'), pinned: true),
        SliverPadding(
          padding: context.spacingAll.copyWith(bottom: 24),
          sliver: const SliverToBoxAdapter(child: PromotionsBannerLayout()),
        ),
        const SliverToBoxAdapter(child: ReleasesLatestFeedList()),
        const SliverToBoxAdapter(child: ScheduleNowFeedList()),
        const SliverToBoxAdapter(child: VideoContentRandomFeedList()),
        const SliverToBoxAdapter(child: FranchisesRandomFeedList()),
        const SliverToBoxAdapter(child: GenresRandomFeedList()),
      ],
    ),
  );
}
