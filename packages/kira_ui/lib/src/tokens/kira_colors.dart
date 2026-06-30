import 'package:flutter/material.dart';
import 'package:kira_ui/src/tokens/kira_palette.dart';

/// Semantic color tokens of the KIRA design system (Figma collection `Color`).
///
/// These alias the raw [KiraPalette] primitives and are what components consume.
/// Exposed as a [ThemeExtension] — read via `Theme.of(context).extension<…>()`
/// or the `context.kiraColors` shortcut.
@immutable
class KiraColors extends ThemeExtension<KiraColors> {
  const KiraColors({
    required this.bg,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceOverlay,
    required this.surfaceHover,
    required this.text,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.accent,
    required this.accentHover,
    required this.accentPressed,
    required this.accentSoft,
    required this.cyan,
    required this.cyanHover,
    required this.gold,
    required this.onAccent,
    required this.border,
    required this.borderStrong,
    required this.success,
    required this.warning,
    required this.danger,
    required this.scrim,
    required this.overlaySoft,
    required this.glassFill,
    required this.glassBorder,
    required this.iconDefault,
    required this.iconMuted,
    required this.iconActive,
    required this.stateAccentTint,
    required this.stateAccentOutline,
  });

  /// The single (dark) mode of the KIRA palette.
  static const KiraColors dark = KiraColors(
    bg: KiraPalette.ink950,
    surface: KiraPalette.ink900,
    surfaceRaised: KiraPalette.ink850,
    surfaceOverlay: KiraPalette.ink800,
    surfaceHover: KiraPalette.ink700,
    text: KiraPalette.paper100,
    textSecondary: KiraPalette.paper300,
    textMuted: KiraPalette.paper500,
    textInverse: KiraPalette.onAccent,
    accent: KiraPalette.magenta500,
    accentHover: KiraPalette.magenta400,
    accentPressed: KiraPalette.magenta600,
    accentSoft: KiraPalette.magenta300,
    cyan: KiraPalette.cyan500,
    cyanHover: KiraPalette.cyan300,
    gold: KiraPalette.gold500,
    onAccent: KiraPalette.onAccent,
    border: KiraPalette.whiteA07,
    borderStrong: KiraPalette.whiteA14,
    success: KiraPalette.success,
    warning: KiraPalette.warning,
    danger: KiraPalette.danger,
    scrim: KiraPalette.blackA55,
    overlaySoft: KiraPalette.blackA50,
    glassFill: KiraPalette.whiteA10,
    glassBorder: KiraPalette.whiteA18,
    iconDefault: KiraPalette.paper300,
    iconMuted: KiraPalette.paper500,
    iconActive: KiraPalette.magenta500,
    stateAccentTint: KiraPalette.magentaA15,
    stateAccentOutline: KiraPalette.magentaA50,
  );

  /// Page background — the near-black base.
  final Color bg;

  /// Default raised surface (cards, sheets).
  final Color surface;
  final Color surfaceRaised;
  final Color surfaceOverlay;
  final Color surfaceHover;

  /// Primary text.
  final Color text;
  final Color textSecondary;
  final Color textMuted;

  /// Text on top of bright accent fills.
  final Color textInverse;

  /// Primary brand accent (magenta) and its states.
  final Color accent;
  final Color accentHover;
  final Color accentPressed;
  final Color accentSoft;

  /// Secondary accent (cyan).
  final Color cyan;
  final Color cyanHover;

  /// Tertiary accent (gold).
  final Color gold;

  /// Ink color placed on top of accent fills.
  final Color onAccent;

  /// Hairline / strong borders (translucent white).
  final Color border;
  final Color borderStrong;

  // Status.
  final Color success;
  final Color warning;
  final Color danger;

  /// Image/billboard scrims and soft overlays.
  final Color scrim;
  final Color overlaySoft;

  /// Translucent glass surfaces (glass navbars / panels).
  final Color glassFill;
  final Color glassBorder;

  /// Icon tints.
  final Color iconDefault;
  final Color iconMuted;
  final Color iconActive;

  /// Accent state layers — hover/selected tint and focus outline.
  final Color stateAccentTint;
  final Color stateAccentOutline;

  @override
  KiraColors copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceRaised,
    Color? surfaceOverlay,
    Color? surfaceHover,
    Color? text,
    Color? textSecondary,
    Color? textMuted,
    Color? textInverse,
    Color? accent,
    Color? accentHover,
    Color? accentPressed,
    Color? accentSoft,
    Color? cyan,
    Color? cyanHover,
    Color? gold,
    Color? onAccent,
    Color? border,
    Color? borderStrong,
    Color? success,
    Color? warning,
    Color? danger,
    Color? scrim,
    Color? overlaySoft,
    Color? glassFill,
    Color? glassBorder,
    Color? iconDefault,
    Color? iconMuted,
    Color? iconActive,
    Color? stateAccentTint,
    Color? stateAccentOutline,
  }) {
    return KiraColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      surfaceHover: surfaceHover ?? this.surfaceHover,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textInverse: textInverse ?? this.textInverse,
      accent: accent ?? this.accent,
      accentHover: accentHover ?? this.accentHover,
      accentPressed: accentPressed ?? this.accentPressed,
      accentSoft: accentSoft ?? this.accentSoft,
      cyan: cyan ?? this.cyan,
      cyanHover: cyanHover ?? this.cyanHover,
      gold: gold ?? this.gold,
      onAccent: onAccent ?? this.onAccent,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      scrim: scrim ?? this.scrim,
      overlaySoft: overlaySoft ?? this.overlaySoft,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      iconDefault: iconDefault ?? this.iconDefault,
      iconMuted: iconMuted ?? this.iconMuted,
      iconActive: iconActive ?? this.iconActive,
      stateAccentTint: stateAccentTint ?? this.stateAccentTint,
      stateAccentOutline: stateAccentOutline ?? this.stateAccentOutline,
    );
  }

  @override
  KiraColors lerp(covariant KiraColors? other, double t) {
    if (other == null) return this;
    return KiraColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      surfaceHover: Color.lerp(surfaceHover, other.surfaceHover, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentHover: Color.lerp(accentHover, other.accentHover, t)!,
      accentPressed: Color.lerp(accentPressed, other.accentPressed, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      cyanHover: Color.lerp(cyanHover, other.cyanHover, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      overlaySoft: Color.lerp(overlaySoft, other.overlaySoft, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      iconActive: Color.lerp(iconActive, other.iconActive, t)!,
      stateAccentTint: Color.lerp(stateAccentTint, other.stateAccentTint, t)!,
      stateAccentOutline: Color.lerp(
        stateAccentOutline,
        other.stateAccentOutline,
        t,
      )!,
    );
  }
}
