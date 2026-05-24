import 'package:url_launcher/url_launcher.dart';
import 'package:yx_state/yx_state.dart';

enum UrlLauncherState {
  idle,
  progress,
  success,
  error;

  bool get isIdle => this == idle;
  bool get isProgress => this == progress;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}

abstract interface class UrlLauncher
    implements StateReadable<UrlLauncherState> {
  void open(Uri url);
}

final class UrlLauncherStateManager extends StateManager<UrlLauncherState>
    implements UrlLauncher {
  UrlLauncherStateManager() : super(UrlLauncherState.idle);

  @override
  Future<void> open(Uri url) => handle(
    (emit) async {
      try {
        emit(UrlLauncherState.progress);
        final canLaunch = await canLaunchUrl(url);
        if (!canLaunch) {
          emit(UrlLauncherState.error);
          return;
        }

        await launchUrl(url).timeout(const Duration(seconds: 3));
        emit(UrlLauncherState.success);
      } on Object {
        emit(UrlLauncherState.error);
        rethrow;
      } finally {
        emit(UrlLauncherState.idle);
      }
    },
    identifier: 'open',
  );
}
