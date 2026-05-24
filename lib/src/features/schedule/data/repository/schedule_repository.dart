import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/data/datasource/datasource.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleRepository implements IScheduleRepository {
  final ScheduleRemoteDB _remoteDB;

  const ScheduleRepository({required this._remoteDB});

  @override
  Future<AnimeScheduleNowModel> readScheduleNowFromNetwork() =>
      _remoteDB.getScheduleNow();

  @override
  Future<AnimeSchedulePublishListModel> readScheduleWeekFromNetwork() async {
    final weekData = await _remoteDB.getScheduleWeek();

    // Группируем расписания по дням выхода и сразу сортируем внутри групп
    final groupedSchedules =
        <AnimeReleasePublishDayModel, List<AnimeScheduleModel>>{};

    for (final schedule in weekData.schedules) {
      final publishDay = schedule.release.publishDay;
      groupedSchedules.putIfAbsent(publishDay, () => []).add(schedule);
    }

    // Сортируем дни выхода и сразу формируем итоговый список с отсортированными расписаниями
    final publishSchedules = groupedSchedules.entries.map((entry) {
      // Сортируем расписания внутри каждого дня по времени выхода
      entry.value.sort(
        (a, b) => a.release.updatedAt.compareTo(b.release.updatedAt),
      );
      return AnimeSchedulePublishModel(
        publishDay: entry.key,
        schedules: List<AnimeScheduleModel>.unmodifiable(entry.value),
      );
    }).toList();

    // Сортируем итоговый список по дню выхода
    // ignore: cascade_invocations
    publishSchedules.sort(
      (a, b) => a.publishDay.value.compareTo(b.publishDay.value),
    );

    return AnimeSchedulePublishListModel(
      publishSchedules: List<AnimeSchedulePublishModel>.unmodifiable(
        publishSchedules,
      ),
    );
  }
}
