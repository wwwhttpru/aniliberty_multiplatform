import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IFranchisesAllWM {
  /// Получить список всех франшиз
  void read();
}

@immutable
class FranchisesAllWM implements IFranchisesAllWM {
  final FranchisesSM _franchisesSM;

  const FranchisesAllWM({required this._franchisesSM});

  @override
  void read() {
    if (_franchisesSM.state.isProgress || _franchisesSM.state.isSuccess) {
      return;
    }

    _franchisesSM.readAll();
  }
}
