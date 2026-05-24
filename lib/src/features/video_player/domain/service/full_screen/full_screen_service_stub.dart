import 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/i_full_screen_service.dart';

/// Creates an instance of FullScreenService for platforms where fullscreen mode is not supported
IFullScreenService createFullScreenService() => throw UnsupportedError(
  'createFullScreenService is not supported on this platform',
);
