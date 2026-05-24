import 'package:aniliberty_multiplatform/src/features/franchises/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class FranchisesSM extends StateManager<FranchisesState> {
  final IFranchisesRepository _repository;

  FranchisesSM({required this._repository})
    : super(const FranchisesState.idle());

  void readRandom(int limit) {
    handle((emit) async {
      emit(const FranchisesState.progress());

      try {
        final animeFranchises = await _repository
            .readRandomFranchisesFromNetwork(limit: limit);

        emit(FranchisesState.success(animeFranchises: animeFranchises));
      } on Object catch (error, sk) {
        emit(const FranchisesState.error());
        addError(error, sk);
      }
    });
  }

  void readAll() {
    handle((emit) async {
      emit(const FranchisesState.progress());

      try {
        final animeFranchises = await _repository.readFranchisesFromNetwork();
        emit(FranchisesState.success(animeFranchises: animeFranchises));
      } on Object catch (error, sk) {
        emit(const FranchisesState.error());
        addError(error, sk);
      }
    });
  }
}
