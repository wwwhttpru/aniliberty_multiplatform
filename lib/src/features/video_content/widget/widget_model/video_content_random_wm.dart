import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template video_content_random_wm}
/// Widget model for video content random screen.
/// {@endtemplate}
abstract interface class IVideoContentRandomWM {
  /// Loads random video content with a limit
  void read();

  /// Opens the video content all screen
  void openAll();

  /// Opens a specific video content
  ///
  /// [url] - The URL of the video content to open
  void openVideoContent(String url);
}

/// {@macro video_content_random_wm}
@immutable
class VideoContentRandomWM implements IVideoContentRandomWM {
  /// {@macro video_content_sm}
  final VideoContentSM _videoContentRandomSM;

  /// {@macro video_content_navigation_interactor}
  final IVideoContentNavigationInteractor _navigationInteractor;

  /// {@macro url_launcher}
  final UrlLauncher _urlLauncher;

  /// {@macro video_content_random_wm}
  const VideoContentRandomWM({
    required this._videoContentRandomSM,
    required this._navigationInteractor,
    required this._urlLauncher,
  });

  @override
  void read() {
    final state = _videoContentRandomSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _videoContentRandomSM.read(5);
  }

  @override
  void openAll() => _navigationInteractor.openVideoContentAll();

  @override
  void openVideoContent(String url) {
    if (_urlLauncher.state.isProgress) {
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    _urlLauncher.open(uri);
  }
}
