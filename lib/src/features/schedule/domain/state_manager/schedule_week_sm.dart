import 'package:aniliberty_multiplatform/src/features/schedule/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class ScheduleWeekSM extends StateManager<ScheduleWeekState> {
  final IScheduleRepository _repository;

  ScheduleWeekSM({required this._repository})
    : super(const ScheduleWeekState.idle());

  void read() => handle((emit) async {
    emit(const ScheduleWeekState.progress());
    try {
      final data = await _repository.readScheduleWeekFromNetwork();
      emit(ScheduleWeekState.success(animeScheduleWeek: data));
    } on Object catch (error, sk) {
      emit(const ScheduleWeekState.error());
      addError(error, sk);
    }
  });
}
