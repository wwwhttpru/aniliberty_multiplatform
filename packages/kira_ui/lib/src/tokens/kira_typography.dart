import 'package:flutter/material.dart';

/// Font families of the KIRA design system, namespaced to the `kira_ui`
/// package so the bundled fonts resolve in any consuming app.
abstract final class KiraFontFamily {
  /// Display / headings. Latin only — falls back to [displayFallback] for
  /// Cyrillic (Space Grotesk ships no Cyrillic glyphs).
  static const String display = 'packages/kira_ui/Space Grotesk';

  /// Cyrillic fallback for [display].
  static const String displayFallback = 'packages/kira_ui/Onest';

  /// Body text (Latin + Cyrillic).
  static const String body = 'packages/kira_ui/Manrope';

  /// Monospace labels (Latin + Cyrillic), used UPPER-cased.
  static const String mono = 'packages/kira_ui/JetBrains Mono';
}

const List<String> _displayFallback = [KiraFontFamily.displayFallback];

/// Typography tokens (Figma text styles). Colors are intentionally omitted —
/// they come from `KiraColors` / the ambient text color.
///
/// Mono styles are designed for UPPER-cased text; uppercase at the call site
/// (their tracking is tuned for caps).
@immutable
class KiraTypography extends ThemeExtension<KiraTypography> {
  const KiraTypography({
    required this.display2xl,
    required this.displayXl,
    required this.displayLg,
    required this.displayMd,
    required this.titleLg,
    required this.titleMd,
    required this.bodyLg,
    required this.bodyMd,
    required this.bodySm,
    required this.labelButton,
    required this.labelSmall,
    required this.monoMd,
    required this.monoSm,
    required this.monoXs,
    required this.numeric,
    required this.titleCard,
    required this.labelNav,
  });

  /// The canonical KIRA type ramp.
  static const KiraTypography standard = KiraTypography(
    display2xl: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 56,
      height: 54 / 56,
      letterSpacing: -1.96,
    ),
    displayXl: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 40,
      height: 40 / 40,
      letterSpacing: -1.2,
    ),
    displayLg: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 34 / 32,
      letterSpacing: -0.8,
    ),
    displayMd: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 26,
      height: 29 / 26,
      letterSpacing: -0.52,
    ),
    titleLg: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 24 / 20,
      letterSpacing: -0.2,
    ),
    titleMd: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 17,
      height: 21 / 17,
      letterSpacing: -0.17,
    ),
    bodyLg: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
    ),
    bodyMd: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 22 / 14,
    ),
    bodySm: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 20 / 13,
    ),
    labelButton: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 16 / 14,
      letterSpacing: -0.07,
    ),
    labelSmall: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 16 / 12,
    ),
    monoMd: TextStyle(
      fontFamily: KiraFontFamily.mono,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 1.68,
    ),
    monoSm: TextStyle(
      fontFamily: KiraFontFamily.mono,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      height: 14 / 10,
      letterSpacing: 1.6,
    ),
    monoXs: TextStyle(
      fontFamily: KiraFontFamily.mono,
      fontWeight: FontWeight.w500,
      fontSize: 9,
      height: 12 / 9,
      letterSpacing: 1.62,
    ),
    numeric: TextStyle(
      fontFamily: KiraFontFamily.display,
      fontFamilyFallback: _displayFallback,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 24 / 22,
      letterSpacing: -0.2,
    ),
    titleCard: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 18 / 14,
    ),
    labelNav: TextStyle(
      fontFamily: KiraFontFamily.body,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
    ),
  );

  // Display.
  final TextStyle display2xl;
  final TextStyle displayXl;
  final TextStyle displayLg;
  final TextStyle displayMd;

  // Titles.
  final TextStyle titleLg;
  final TextStyle titleMd;

  // Body.
  final TextStyle bodyLg;
  final TextStyle bodyMd;
  final TextStyle bodySm;

  // Labels.
  final TextStyle labelButton;
  final TextStyle labelSmall;

  // Mono (UPPER).
  final TextStyle monoMd;
  final TextStyle monoSm;
  final TextStyle monoXs;

  /// Tabular display figures (ranks, counters).
  final TextStyle numeric;

  /// Card title (compact, body family).
  final TextStyle titleCard;

  /// Navigation item label.
  final TextStyle labelNav;

  @override
  KiraTypography copyWith({
    TextStyle? display2xl,
    TextStyle? displayXl,
    TextStyle? displayLg,
    TextStyle? displayMd,
    TextStyle? titleLg,
    TextStyle? titleMd,
    TextStyle? bodyLg,
    TextStyle? bodyMd,
    TextStyle? bodySm,
    TextStyle? labelButton,
    TextStyle? labelSmall,
    TextStyle? monoMd,
    TextStyle? monoSm,
    TextStyle? monoXs,
    TextStyle? numeric,
    TextStyle? titleCard,
    TextStyle? labelNav,
  }) {
    return KiraTypography(
      display2xl: display2xl ?? this.display2xl,
      displayXl: displayXl ?? this.displayXl,
      displayLg: displayLg ?? this.displayLg,
      displayMd: displayMd ?? this.displayMd,
      titleLg: titleLg ?? this.titleLg,
      titleMd: titleMd ?? this.titleMd,
      bodyLg: bodyLg ?? this.bodyLg,
      bodyMd: bodyMd ?? this.bodyMd,
      bodySm: bodySm ?? this.bodySm,
      labelButton: labelButton ?? this.labelButton,
      labelSmall: labelSmall ?? this.labelSmall,
      monoMd: monoMd ?? this.monoMd,
      monoSm: monoSm ?? this.monoSm,
      monoXs: monoXs ?? this.monoXs,
      numeric: numeric ?? this.numeric,
      titleCard: titleCard ?? this.titleCard,
      labelNav: labelNav ?? this.labelNav,
    );
  }

  @override
  KiraTypography lerp(covariant KiraTypography? other, double t) {
    if (other == null) return this;
    return KiraTypography(
      display2xl: TextStyle.lerp(display2xl, other.display2xl, t)!,
      displayXl: TextStyle.lerp(displayXl, other.displayXl, t)!,
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      titleLg: TextStyle.lerp(titleLg, other.titleLg, t)!,
      titleMd: TextStyle.lerp(titleMd, other.titleMd, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      labelButton: TextStyle.lerp(labelButton, other.labelButton, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      monoMd: TextStyle.lerp(monoMd, other.monoMd, t)!,
      monoSm: TextStyle.lerp(monoSm, other.monoSm, t)!,
      monoXs: TextStyle.lerp(monoXs, other.monoXs, t)!,
      numeric: TextStyle.lerp(numeric, other.numeric, t)!,
      titleCard: TextStyle.lerp(titleCard, other.titleCard, t)!,
      labelNav: TextStyle.lerp(labelNav, other.labelNav, t)!,
    );
  }
}
