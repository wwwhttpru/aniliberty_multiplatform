import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScheduleWeekScreen extends StatefulWidget {
  const ScheduleWeekScreen({super.key});

  @override
  State<ScheduleWeekScreen> createState() => _ScheduleWeekScreenState();
}

class _ScheduleWeekScreenState extends State<ScheduleWeekScreen> {
  late final IScheduleWeekWM _scheduleWeekWM;

  @override
  void initState() {
    super.initState();
    _scheduleWeekWM = ScheduleScope.scheduleWeekWMOf(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _scheduleWeekWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ScheduleWeekStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeScheduleWeek),
          error: (_) => ErrorLayout(onTap: _scheduleWeekWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeSchedulePublishListModel animeScheduleWeek;

  const _SuccessLayout(this.animeScheduleWeek);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    slivers: [
      SliverPadding(
        padding: context.spacingAll.copyWith(bottom: 16),
        sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
      ),
      SliverList.separated(
        itemBuilder: (context, index) {
          final publish = animeScheduleWeek.publishSchedules[index];
          return _PublishLayout(
            key: ValueKey(publish.publishDay.value),
            publish: publish,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: animeScheduleWeek.publishSchedules.length,
      ),
      SliverPadding(
        padding: context.spacingAll.copyWith(top: 16),
        sliver: const SliverToBoxAdapter(),
      ),
    ],
  );
}

class _PublishLayout extends StatelessWidget {
  final AnimeSchedulePublishModel publish;

  const _PublishLayout({required this.publish, super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: context.spacingH,
        child: Text(
          publish.publishDay.description,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 16),
      GridView.builder(
        padding: context.spacingH,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 9 / 16,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) => AnimeScheduleGridItem(
          key: ValueKey(publish.schedules[index].release.alias),
          animeSchedule: publish.schedules[index],
        ),
        itemCount: publish.schedules.length,
      ),
    ],
  );
}
