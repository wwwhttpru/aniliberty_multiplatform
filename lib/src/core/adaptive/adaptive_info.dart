import 'package:aniliberty_multiplatform/src/core/adaptive/platform_type.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/window_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Информация об адаптивности приложения
/// Содержит данные о размере экрана и типе платформы
@immutable
class AdaptiveInfo {
  /// Размер экрана с адаптивными возможностями
  final WindowSize windowSize;

  /// Тип платформы (iOS, Android, Web, Desktop)
  final PlatformType platformType;

  const AdaptiveInfo({
    required this.windowSize,
    required this.platformType,
  });

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveInfo) {
      return windowSize == other.windowSize &&
          platformType == other.platformType;
    }
    return false;
  }

  @override
  int get hashCode => windowSize.hashCode ^ platformType.hashCode;
}
