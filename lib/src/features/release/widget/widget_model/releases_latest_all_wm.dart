import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IReleasesLatestAllWM {
  /// Загрузить данные всех последних релизов
  void read();
}

@immutable
class ReleasesLatestAllWM implements IReleasesLatestAllWM {
  final ReleasesSM _releasesSM;

  const ReleasesLatestAllWM({required this._releasesSM});

  @override
  void read() {
    final state = _releasesSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _releasesSM.readLatest(42);
  }
}
