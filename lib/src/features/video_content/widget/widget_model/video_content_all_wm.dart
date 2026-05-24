import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template video_content_all_wm}
/// Widget model for video content all screen.
/// {@endtemplate}
abstract interface class IVideoContentAllWM {
  /// Closes the video content all screen
  void close();

  /// Loads all video content with a limit
  void read();

  /// Opens a specific video content
  ///
  /// [url] - The URL of the video content to open
  void openVideoContent(String url);
}

/// {@macro video_content_all_wm}
@immutable
class VideoContentAllWM implements IVideoContentAllWM {
  /// {@macro video_content_sm}
  final VideoContentSM _videoContentAllSM;

  /// {@macro video_content_navigation_interactor}
  final IVideoContentNavigationInteractor _navigationInteractor;

  /// {@macro url_launcher}
  final UrlLauncher _urlLauncher;

  /// {@macro video_content_all_wm}
  const VideoContentAllWM({
    required this._videoContentAllSM,
    required this._urlLauncher,
    required this._navigationInteractor,
  });

  @override
  void close() => _navigationInteractor.closeVideoContentAll();

  @override
  void read() {
    final state = _videoContentAllSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _videoContentAllSM.read(28);
  }

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
