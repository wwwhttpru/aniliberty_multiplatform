import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IFranchiseWM {
  /// Получить информацию о франшизе
  void read();
}

@immutable
class FranchiseWM implements IFranchiseWM {
  final FranchiseSM _franchiseSM;

  const FranchiseWM({required this._franchiseSM});

  @override
  void read() {
    if (_franchiseSM.state.isProgress || _franchiseSM.state.isSuccess) {
      return;
    }

    _franchiseSM.read();
  }
}
