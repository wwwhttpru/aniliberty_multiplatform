import 'package:flutter/widgets.dart';

/// Material Design 3 window size classes
///
/// See more: <https://m3.material.io/foundations/layout/applying-layout/window-size-classes>
extension type const WindowSize(Size size) implements Size {
  /// Compact width (width < 600dp)
  ///
  /// 99.96% of phones in portrait
  static const _compactWidth = 600.0;

  /// Medium width (600dp ≤ width < 840dp)
  ///
  /// 93.73% of tablets in portrait, most large unfolded inner displays in portrait
  static const _mediumWidth = 840.0;

  /// Expanded width (840dp ≤ width < 1200dp)
  ///
  /// 97.22% of tablets in landscape,
  /// most large unfolded inner displays in landscape are at least expanded width
  static const _expandedWidth = 1200.0;

  /// Large width (1200dp ≤ width < 1600dp)
  ///
  /// Large tablet displays
  static const _largeWidth = 1600.0;

  /// Extra-large width (width ≥ 1600dp)
  ///
  /// Desktop displays
  /// Note: Uses _largeWidth as the breakpoint

  /// Compact height (height < 480dp)
  ///
  /// 99.78% of phones in landscape
  static const _compactHeight = 480.0;

  /// Medium height (480dp ≤ height < 900dp)
  ///
  /// 96.56% of tablets in landscape,
  /// 97.59% of phones in portrait
  static const _mediumHeight = 900.0;

  /// Expanded height (height ≥ 900dp)
  ///
  /// 94.25% of tablets in portrait
  /// Note: Uses _mediumHeight as the breakpoint

  /// Return true if width is less than compact width
  bool get isCompactWidth => maybeMapWidth<bool>(
    compact: () => true,
    orElse: () => false,
  );

  /// Return true if width is between compact width and medium width
  bool get isMediumWidth => maybeMapWidth<bool>(
    medium: () => true,
    orElse: () => false,
  );

  /// Return true if width is in expanded size class (840dp ≤ width < 1200dp)
  bool get isExpandedWidth => maybeMapWidth<bool>(
    expanded: () => true,
    orElse: () => false,
  );

  /// Return true if width is between expanded width and large width
  bool get isLargeWidth => maybeMapWidth<bool>(
    large: () => true,
    orElse: () => false,
  );

  /// Return true if width is greater than or equal to extra large width
  bool get isExtraLargeWidth => maybeMapWidth<bool>(
    extraLarge: () => true,
    orElse: () => false,
  );

  /// Return true if height is less than compact height
  bool get isCompactHeight => maybeMapHeight<bool>(
    compact: () => true,
    orElse: () => false,
  );

  /// Return true if height is between compact height and medium height
  bool get isMediumHeight => maybeMapHeight<bool>(
    medium: () => true,
    orElse: () => false,
  );

  /// Return true if height is greater than or equal to medium height
  bool get isExpandedHeight => maybeMapHeight<bool>(
    expanded: () => true,
    orElse: () => false,
  );

  /// Map width to a specific size class
  T mapWidth<T>({
    required T Function() compact,
    required T Function() medium,
    required T Function() expanded,
    required T Function() large,
    required T Function() extraLarge,
  }) => switch (size.width) {
    < _compactWidth => compact(),
    < _mediumWidth => medium(),
    < _expandedWidth => expanded(),
    < _largeWidth => large(),
    _ => extraLarge(),
  };

  /// Map width to a specific size class with an optional fallback
  T maybeMapWidth<T>({
    required T Function() orElse,
    T Function()? compact,
    T Function()? medium,
    T Function()? expanded,
    T Function()? large,
    T Function()? extraLarge,
  }) => mapWidth(
    compact: compact ?? orElse,
    medium: medium ?? orElse,
    expanded: expanded ?? orElse,
    large: large ?? orElse,
    extraLarge: extraLarge ?? orElse,
  );

  /// Map width to a specific size class with a fallback to the lower size,
  /// if the value is not provided.
  T mapWidthWithLowerFallback<T>({
    required T Function() compact,
    T Function()? medium,
    T Function()? expanded,
    T Function()? large,
    T Function()? extraLarge,
  }) => mapWidth(
    compact: compact,
    medium: medium ?? compact,
    expanded: expanded ?? medium ?? compact,
    large: large ?? expanded ?? medium ?? compact,
    extraLarge: extraLarge ?? large ?? expanded ?? medium ?? compact,
  );

  /// Map width to a specific size class with a fallback to the higher size,
  /// if the value is not provided.
  T mapWidthWithHigherFallback<T>({
    required T Function() extraLarge,
    T Function()? large,
    T Function()? expanded,
    T Function()? medium,
    T Function()? compact,
  }) => mapWidth(
    compact: compact ?? medium ?? expanded ?? large ?? extraLarge,
    medium: medium ?? expanded ?? large ?? extraLarge,
    expanded: expanded ?? large ?? extraLarge,
    large: large ?? extraLarge,
    extraLarge: extraLarge,
  );

  /// Map height to a specific size class
  T mapHeight<T>({
    required T Function() compact,
    required T Function() medium,
    required T Function() expanded,
  }) => switch (size.height) {
    < _compactHeight => compact(),
    < _mediumHeight => medium(),
    _ => expanded(),
  };

  /// Map height to a specific size class with an optional fallback
  T maybeMapHeight<T>({
    required T Function() orElse,
    T Function()? compact,
    T Function()? medium,
    T Function()? expanded,
  }) => mapHeight<T>(
    compact: compact ?? orElse,
    medium: medium ?? orElse,
    expanded: expanded ?? orElse,
  );

  /// Map height to a specific size class with a fallback to the lower size,
  /// if the value is not provided.
  T mapHeightWithLowerFallback<T>({
    required T Function() compact,
    T Function()? medium,
    T Function()? expanded,
  }) => mapHeight<T>(
    compact: compact,
    medium: medium ?? compact,
    expanded: expanded ?? medium ?? compact,
  );

  /// Map height to a specific size class with a fallback to the higher size,
  /// if the value is not provided.
  T mapHeightWithHigherFallback<T>({
    required T Function() expanded,
    T Function()? medium,
    T Function()? compact,
  }) => mapHeight<T>(
    compact: compact ?? medium ?? expanded,
    medium: medium ?? expanded,
    expanded: expanded,
  );

  /// Spacing
  double get spacing => mapWidth<double>(
    compact: () => 16,
    medium: () => 24,
    expanded: () => 24,
    large: () => 24,
    extraLarge: () => 24,
  );

  /// EdgeInsets all
  EdgeInsets get edgeInsetsAll => .all(spacing);

  /// EdgeInsets horizontal
  EdgeInsets get edgeInsetsH => .symmetric(horizontal: spacing);

  /// EdgeInsets vertical
  EdgeInsets get edgeInsetsV => .symmetric(vertical: spacing);
}
