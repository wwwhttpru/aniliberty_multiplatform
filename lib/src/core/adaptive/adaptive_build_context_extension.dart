import 'dart:math' as math;

import 'package:aniliberty_multiplatform/src/core/adaptive/adaptive_info.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/adaptive_scope.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/platform_type.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/window_size.dart';
import 'package:flutter/widgets.dart';

/// Extension methods for the build context to access the adaptive info
extension AdaptiveBuildContextExtension on BuildContext {
  /// Get the adaptive info from the adaptive scope
  AdaptiveInfo get adaptiveInfo => AdaptiveScope.of(this);

  /// Get the adaptive info from the adaptive scope without listening
  AdaptiveInfo get readAdaptiveInfo => AdaptiveScope.of(this, listen: false);

  /// Get the window size from the adaptive scope
  WindowSize get windowSize => adaptiveInfo.windowSize;

  /// Get the window size from the adaptive scope without listening
  WindowSize get readWindowSize => readAdaptiveInfo.windowSize;

  /// Get the platform type from the adaptive scope
  PlatformType get platformType => adaptiveInfo.platformType;

  /// Get the platform type from the adaptive scope without listening
  PlatformType get readPlatformType => readAdaptiveInfo.platformType;

  /// Get the spacing from the adaptive scope
  double get spacing => windowSize.spacing;

  /// Get the spacing all from the adaptive scope
  EdgeInsets get spacingAll => windowSize.edgeInsetsAll;

  /// Get the spacing horizontal from the adaptive scope
  EdgeInsets get spacingH => windowSize.edgeInsetsH;

  /// Get the spacing vertical from the adaptive scope
  EdgeInsets get spacingV => windowSize.edgeInsetsV;

  /// Get the spacing all from the adaptive scope with safe area
  EdgeInsets get spacingAllOrSa {
    final minimum = spacingAll;
    final padding = MediaQuery.paddingOf(this);
    return .only(
      left: math.max(padding.left, minimum.left),
      top: math.max(padding.top, minimum.top),
      right: math.max(padding.right, minimum.right),
      bottom: math.max(padding.bottom, minimum.bottom),
    );
  }

  /// Get the spacing horizontal from the adaptive scope with safe area
  EdgeInsets get spacingHOrSa {
    final minimum = spacingH;
    final padding = MediaQuery.paddingOf(this);
    return .only(
      left: math.max(padding.left, minimum.left),
      right: math.max(padding.right, minimum.right),
    );
  }

  /// Get the spacing vertical from the adaptive scope with safe area
  EdgeInsets get spacingVOrSa {
    final minimum = spacingV;
    final padding = MediaQuery.paddingOf(this);
    return .only(
      top: math.max(padding.top, minimum.top),
      bottom: math.max(padding.bottom, minimum.bottom),
    );
  }
}
