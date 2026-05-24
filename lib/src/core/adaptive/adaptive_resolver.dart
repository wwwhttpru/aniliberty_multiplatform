import 'package:aniliberty_multiplatform/src/core/adaptive/adaptive_scope.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/window_size.dart';
import 'package:flutter/material.dart';

/// Система адаптивного разрешения значений
/// Позволяет устанавливать различные значения в зависимости от размера экрана
class AdaptiveResolver {
  final WindowSize windowSize;

  const AdaptiveResolver(this.windowSize);

  // ===== РАЗМЕРЫ СКРУГЛЕНИЯ =====

  /// Адаптивный радиус скругления для shimmer
  Radius get shimmerRadius => windowSize.mapWidth(
    compact: () => const .circular(8),
    medium: () => const .circular(10),
    expanded: () => const .circular(12),
    large: () => const .circular(14),
    extraLarge: () => const .circular(16),
  );

  /// Адаптивный радиус скругления для карточек
  BorderRadius get cardBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );

  /// Адаптивный радиус скругления для кнопок
  BorderRadius get buttonBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(6)),
    medium: () => const BorderRadius.all(Radius.circular(8)),
    expanded: () => const BorderRadius.all(Radius.circular(10)),
    large: () => const BorderRadius.all(Radius.circular(12)),
    extraLarge: () => const BorderRadius.all(Radius.circular(14)),
  );

  /// Адаптивный радиус скругления для чипов
  BorderRadius get chipBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );

  BorderRadius get splashBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );

  BorderRadius get listTileBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );

  BorderRadius get inputBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );

  BorderRadius get snackBarBorderRadius => windowSize.mapWidth(
    compact: () => const BorderRadius.all(Radius.circular(8)),
    medium: () => const BorderRadius.all(Radius.circular(10)),
    expanded: () => const BorderRadius.all(Radius.circular(12)),
    large: () => const BorderRadius.all(Radius.circular(14)),
    extraLarge: () => const BorderRadius.all(Radius.circular(16)),
  );
  // ===== ФОРМЫ ЭЛЕМЕНТОВ =====

  /// Адаптивная форма для карточек
  RoundedRectangleBorder get cardShape => RoundedRectangleBorder(
    borderRadius: cardBorderRadius,
  );

  /// Адаптивная форма для кнопок
  RoundedRectangleBorder get buttonShape => RoundedRectangleBorder(
    borderRadius: buttonBorderRadius,
  );

  /// Адаптивная форма для чипов
  RoundedRectangleBorder get chipShape => RoundedRectangleBorder(
    borderRadius: chipBorderRadius,
  );

  RoundedRectangleBorder get listTileShape => RoundedRectangleBorder(
    borderRadius: listTileBorderRadius,
  );

  OutlineInputBorder get inputBorder => OutlineInputBorder(
    borderRadius: inputBorderRadius,
  );

  RoundedRectangleBorder get snackBarShape => RoundedRectangleBorder(
    borderRadius: snackBarBorderRadius,
  );

  // ===== УНИВЕРСАЛЬНЫЕ МЕТОДЫ =====

  /// Универсальный метод для получения адаптивного значения
  /// Маппинг legacy категорий на Material Design 3:
  /// - small, medium -> compact (< 600dp)
  /// - large -> medium (600-840dp)
  /// - tablet, desktop -> expanded (840-1200dp)
  /// - largeDesktop -> large (1200-1600dp) или extraLarge (>= 1600dp)
  T resolve<T>({
    required T small,
    required T medium,
    required T large,
    required T tablet,
    required T desktop,
    required T largeDesktop,
  }) => windowSize.mapWidth(
    compact: () => small, // < 600dp: small или medium
    medium: () => large, // 600-840dp: large
    expanded: () => tablet, // 840-1200dp: tablet
    large: () => desktop, // 1200-1600dp: desktop
    extraLarge: () => largeDesktop, // >= 1600dp: largeDesktop
  );

  /// Упрощенный метод для получения адаптивного значения
  /// Для обратной совместимости использует старую сигнатуру:
  /// - compact: < 600dp (Material Design 3 Compact)
  /// - expanded: 600-840dp (Material Design 3 Medium)
  /// - large: >= 840dp (Material Design 3 Expanded, Large, ExtraLarge)
  T adaptive<T>({
    required T compact,
    required T expanded,
    required T large,
  }) => windowSize.mapWidth(
    compact: () => compact,
    medium: () => expanded,
    expanded: () => large,
    large: () => large,
    extraLarge: () => large,
  );

  /// Метод для получения значения с fallback
  T maybeAdaptive<T>({
    required T orElse,
    T? small,
    T? medium,
    T? large,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) => windowSize.maybeMapWidth(
    orElse: () => orElse,
    compact: () => small ?? medium ?? orElse,
    medium: () => large ?? orElse,
    expanded: () => tablet ?? orElse,
    large: () => desktop ?? orElse,
    extraLarge: () => largeDesktop ?? orElse,
  );
}

/// Расширение для удобного доступа к адаптивным значениям
extension AdaptiveResolverExtension on BuildContext {
  /// Получает AdaptiveResolver для текущего контекста
  AdaptiveResolver get resolver {
    final windowSize = AdaptiveScope.of(this).windowSize;
    return AdaptiveResolver(windowSize);
  }
}
