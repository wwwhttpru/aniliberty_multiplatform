import 'package:aniliberty_multiplatform/src/features/schedule/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class ScheduleNowSM extends StateManager<ScheduleNowState> {
  final IScheduleRepository _repository;

  ScheduleNowSM({required this._repository})
    : super(const ScheduleNowState.idle());

  void read() => handle((emit) async {
    emit(const ScheduleNowState.progress());
    try {
      final data = await _repository.readScheduleNowFromNetwork();
      emit(ScheduleNowState.success(animeScheduleNow: data));
    } on Object catch (error, sk) {
      emit(const ScheduleNowState.error());
      addError(error, sk);
    }
  });
}
