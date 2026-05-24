import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/feed/feed.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';

class ScheduleNowFeedList extends StatefulWidget {
  const ScheduleNowFeedList({super.key});

  @override
  State<ScheduleNowFeedList> createState() => _ScheduleNowFeedListState();
}

class _ScheduleNowFeedListState extends State<ScheduleNowFeedList> {
  late final IScheduleNowWM _scheduleNowWM;

  @override
  void initState() {
    super.initState();
    _scheduleNowWM = ScheduleScope.scheduleNowWMOf(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _scheduleNowWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => FeedCategoryItem(
    title: 'Расписание релизов',
    subtitle: 'Список релизов, над которыми команда трудится прямо сейчас',
    onTap: _scheduleNowWM.openSchedulesWeek,
    child: ScheduleNowStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeScheduleNow),
          error: (_) => ErrorLayout(onTap: _scheduleNowWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeScheduleNowModel animeScheduleNow;

  const _SuccessLayout(this.animeScheduleNow);

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemBuilder: (context, index) {
      final value = animeScheduleNow.today[index];
      return AnimeScheduleGridItem(
        key: ValueKey(value.release.alias),
        animeSchedule: value,
      );
    },
    itemCount: animeScheduleNow.today.length,
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
      return SizedBox(width: 180, child: child);
    },
    separatorBuilder: (context, index) =>
        const SizedBox(width: FeedCategoryItem.hPadding),
  );
}
