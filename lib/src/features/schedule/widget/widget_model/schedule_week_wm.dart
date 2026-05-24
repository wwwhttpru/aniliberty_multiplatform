import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IScheduleWeekWM {
  /// Получить список новых релизов
  void read();
}

@immutable
class ScheduleWeekWM implements IScheduleWeekWM {
  final ScheduleWeekSM _scheduleWeekSM;

  const ScheduleWeekWM({required this._scheduleWeekSM});

  @override
  void read() {
    final state = _scheduleWeekSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _scheduleWeekSM.read();
  }
}
