import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IFranchisesRandomWM {
  /// Получить список рандомных франшиз
  void read();

  /// Открыть список всех франшиз
  void openAllFranchises();
}

@immutable
class FranchisesRandomWM implements IFranchisesRandomWM {
  final IFranchisesNavigationInteractor _navigationInteractor;
  final FranchisesSM _franchisesSM;

  const FranchisesRandomWM({
    required this._navigationInteractor,
    required this._franchisesSM,
  });

  @override
  void openAllFranchises() => _navigationInteractor.openAllFranchises();

  @override
  void read() {
    if (_franchisesSM.state.isProgress || _franchisesSM.state.isSuccess) {
      return;
    }

    _franchisesSM.readRandom(5);
  }
}
