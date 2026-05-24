import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/app_status.dart';
import 'package:aniliberty_multiplatform/src/features/auth/auth.dart';
import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:meta/meta.dart';

/// {@template more_wm}
/// Widget model for the more screen
/// {@endtemplate}
abstract interface class IMoreWM {
  /// Open login screen
  void openLogin();

  /// Open help screen
  void openHelp();

  /// Open bug report screen
  void openBugReport();

  /// Open general settings screen
  void openGeneralSettings();

  /// Open video settings screen
  void openVideoSettings();

  /// Open app status screen
  void openAppStatus();
}

/// {@macro more_wm}
@immutable
class MoreWM implements IMoreWM {
  /// Navigation controller for managing routes
  final IAuthNavigationInteractor _authNavigationInteractor;

  /// Settings navigation interactor
  final ISettingsNavigationInteractor _settingsNavigationInteractor;

  /// App status navigation interactor
  final IAppStatusNavigationInteractor _appStatusNavigationInteractor;

  /// App url config
  final AppUrlConfig _appUrlConfig;

  /// Url launcher for opening urls
  final UrlLauncher _urlLauncher;

  /// {@macro more_wm}
  const MoreWM({
    required this._authNavigationInteractor,
    required this._settingsNavigationInteractor,
    required this._appStatusNavigationInteractor,
    required this._urlLauncher,
    required this._appUrlConfig,
  });

  @override
  void openLogin() => _authNavigationInteractor.openLogin();

  @override
  void openHelp() {
    if (!_urlLauncher.state.isIdle) {
      return;
    }

    final url = Uri.parse(_appUrlConfig.technicalSupport);
    return _urlLauncher.open(url);
  }

  @override
  void openBugReport() {
    if (!_urlLauncher.state.isIdle) {
      return;
    }

    final url = Uri.parse(_appUrlConfig.bugReport);
    return _urlLauncher.open(url);
  }

  @override
  void openGeneralSettings() =>
      _settingsNavigationInteractor.openGeneralSettings();

  @override
  void openVideoSettings() => _settingsNavigationInteractor.openVideoSettings();

  @override
  void openAppStatus() => _appStatusNavigationInteractor.openAppStatus();
}
