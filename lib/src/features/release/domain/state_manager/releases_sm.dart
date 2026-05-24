import 'package:aniliberty_multiplatform/src/features/release/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class ReleasesSM extends StateManager<ReleasesState> {
  final IReleaseRepository _repository;

  ReleasesSM({
    required this._repository,
  }) : super(const ReleasesState.idle());

  void readLatest(int limit) {
    handle((emit) async {
      emit(const ReleasesState.progress());
      try {
        final releases = await _repository.releasesLatestFromNetwork(
          limit: limit,
        );

        emit(ReleasesState.success(releases: releases));
      } on Object catch (error, sk) {
        emit(const ReleasesState.error());
        addError(error, sk);
      }
    });
  }

  void readRandom(int limit) {
    handle((emit) async {
      emit(const ReleasesState.progress());
      try {
        final releases = await _repository.releasesRandomFromNetwork(
          limit: limit,
        );

        emit(ReleasesState.success(releases: releases));
      } on Object catch (error, sk) {
        emit(const ReleasesState.error());
        addError(error, sk);
      }
    });
  }
}
