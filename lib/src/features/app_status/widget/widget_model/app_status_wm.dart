import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template app_status_wm}
/// Widget model for app status feature
/// {@endtemplate}
abstract interface class IAppStatusWM {
  /// Read app status from the repository
  void read();
}

/// {@macro app_status_wm}
@immutable
final class AppStatusWM implements IAppStatusWM {
  /// App status state manager
  final AppStatusSM _appStatusSM;

  /// {@macro app_status_wm}
  const AppStatusWM({
    required this._appStatusSM,
  });

  @override
  void read() {
    if (_appStatusSM.state.isProgress) {
      return;
    }

    _appStatusSM.read();
  }
}
