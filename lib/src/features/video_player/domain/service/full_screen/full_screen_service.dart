// Conditional imports for different platforms
// ignore: unused_import - conditional imports work so that only one of them is active on each platform
export 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/full_screen_service_stub.dart'
    if (dart.library.js_interop) 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/full_screen_service_web.dart'
    if (dart.library.io) 'package:aniliberty_multiplatform/src/features/video_player/domain/service/full_screen/full_screen_service_io.dart'
    show createFullScreenService;

// Export the interface
export 'i_full_screen_service.dart';
