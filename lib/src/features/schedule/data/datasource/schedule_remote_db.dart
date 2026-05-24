import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

abstract interface class IScheduleRemoteDB {
  /// Возвращает список релизов в расписании на текущую дату
  Future<AnimeScheduleNowModel> getScheduleNow();

  /// Возвращает список релизов в расписании на текущую неделю
  Future<AnimeScheduleWeekModel> getScheduleWeek();
}

/// Подробнее об API: <https://anilibria.top/api/docs/v1#/>
@immutable
final class ScheduleRemoteDB implements IScheduleRemoteDB {
  final AppNetwork _appNetwork;

  const ScheduleRemoteDB({required this._appNetwork});

  @override
  Future<AnimeScheduleNowModel> getScheduleNow() async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/schedule/now',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeScheduleNowModel.fromJson(data);
  }

  @override
  Future<AnimeScheduleWeekModel> getScheduleWeek() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/schedule/week',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeScheduleWeekModel.fromJson({'schedules': data});
  }
}
