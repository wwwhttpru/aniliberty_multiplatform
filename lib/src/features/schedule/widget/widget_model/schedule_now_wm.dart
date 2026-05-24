import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IScheduleNowWM {
  /// Получить список новых релизов
  void read();

  /// Открыть список всех релизов за неделю
  void openSchedulesWeek();
}

@immutable
class ScheduleNowWM implements IScheduleNowWM {
  final ScheduleNowSM _scheduleNowSM;
  final IScheduleNavigationInteractor _navigationInteractor;

  const ScheduleNowWM({
    required this._scheduleNowSM,
    required this._navigationInteractor,
  });

  @override
  void read() {
    final state = _scheduleNowSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _scheduleNowSM.read();
  }

  @override
  void openSchedulesWeek() => _navigationInteractor.openSchedules();
}
