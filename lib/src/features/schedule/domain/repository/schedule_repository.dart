import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

abstract interface class IScheduleRepository {
  /// Возвращает список релизов в расписании на текущую дату
  Future<AnimeScheduleNowModel> readScheduleNowFromNetwork();

  /// Возвращает список релизов в расписании на текущую неделю
  Future<AnimeSchedulePublishListModel> readScheduleWeekFromNetwork();
}
