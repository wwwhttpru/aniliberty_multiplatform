import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IReleasesLatestWM {
  /// Загрузить данные последних релизов
  void read();

  /// Открыть все последние релизы
  void openAll();
}

@immutable
class ReleasesLatestWM implements IReleasesLatestWM {
  final ReleasesSM _releasesSM;
  final IReleasesNavigationInteractor _navigationInteractor;

  const ReleasesLatestWM({
    required this._navigationInteractor,
    required this._releasesSM,
  });

  @override
  void read() {
    final state = _releasesSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _releasesSM.readLatest(6);
  }

  @override
  void openAll() => _navigationInteractor.openLatestAll();
}
