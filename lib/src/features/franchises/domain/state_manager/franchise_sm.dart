import 'package:aniliberty_multiplatform/src/features/franchises/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class FranchiseSM extends StateManager<FranchiseState> {
  final String _franchiseId;
  final IFranchisesRepository _repository;

  FranchiseSM({
    required this._franchiseId,
    required this._repository,
  }) : super(const FranchiseState.idle());

  void read() {
    handle((emit) async {
      emit(const FranchiseState.progress());

      try {
        final animeFranchise = await _repository.readFranchiseByIdFromNetwork(
          franchiseId: _franchiseId,
        );

        emit(FranchiseState.success(animeFranchise: animeFranchise));
      } on Object catch (error, sk) {
        emit(const FranchiseState.error());
        addError(error, sk);
      }
    });
  }
}
