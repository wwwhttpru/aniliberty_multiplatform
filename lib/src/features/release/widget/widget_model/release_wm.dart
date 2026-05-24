import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:meta/meta.dart';

abstract interface class IReleaseWM {
  /// Загрузить данные релиза
  void read();

  /// Открыть эпизод
  void openEpisode(String episodeId);
}

@immutable
class ReleaseWM implements IReleaseWM {
  final ReleaseSM _releaseSM;
  final IReleasesNavigationInteractor _navigationInteractor;

  const ReleaseWM({
    required this._releaseSM,
    required this._navigationInteractor,
  });

  @override
  void read() {
    final state = _releaseSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _releaseSM.read();
  }

  @override
  void openEpisode(String episodeId) =>
      _navigationInteractor.openEpisode(episodeId);
}
