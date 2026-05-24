import 'dart:io';

import 'package:flutter/foundation.dart';

/// Current platform type for application
enum PlatformType {
  /// iOS platform
  ios,

  /// Android platform
  android,

  /// Windows platform
  windows,

  /// macOS platform
  macos,

  /// Linux platform
  linux,

  /// Web platform
  web
  ;

  /// Returns true if the platform is mobile (iOS, Android)
  bool get isMobile => switch (this) {
    PlatformType.ios || PlatformType.android => true,
    _ => false,
  };

  /// Returns true if the platform is desktop (Windows, macOS, Linux)
  bool get isDesktop => switch (this) {
    PlatformType.windows || PlatformType.macos || PlatformType.linux => true,
    _ => false,
  };

  /// Returns true if the platform is web browser
  bool get isWeb => this == PlatformType.web;

  /// Maps the platform type to a specific value
  T map<T>({
    required T Function() ios,
    required T Function() android,
    required T Function() windows,
    required T Function() macos,
    required T Function() linux,
    required T Function() web,
  }) => switch (this) {
    PlatformType.ios => ios(),
    PlatformType.android => android(),
    PlatformType.windows => windows(),
    PlatformType.macos => macos(),
    PlatformType.linux => linux(),
    PlatformType.web => web(),
  };

  /// Maps the platform type to a specific value with a fallback
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? ios,
    T Function()? android,
    T Function()? windows,
    T Function()? macos,
    T Function()? linux,
    T Function()? web,
  }) => map<T>(
    ios: ios ?? orElse,
    android: android ?? orElse,
    windows: windows ?? orElse,
    macos: macos ?? orElse,
    linux: linux ?? orElse,
    web: web ?? orElse,
  );

  /// Determines the current platform based on system parameters
  /// Uses Flutter's kIsWeb and Platform.is* to determine the platform
  static PlatformType getCurrentPlatform() {
    if (kIsWeb) {
      return PlatformType.web;
    }

    if (Platform.isIOS) {
      return PlatformType.ios;
    } else if (Platform.isAndroid) {
      return PlatformType.android;
    } else if (Platform.isWindows) {
      return PlatformType.windows;
    } else if (Platform.isMacOS) {
      return PlatformType.macos;
    } else if (Platform.isLinux) {
      return PlatformType.linux;
    }

    return PlatformType.web;
  }
}
