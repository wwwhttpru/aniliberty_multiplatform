import 'package:flutter/material.dart';

/// Shadow / glow tokens of the KIRA design system (Figma effect styles).
///
/// Neon glows (magenta / cyan / gold) and depth elevations, each as a
/// ready-to-use `List<BoxShadow>` for `BoxDecoration.boxShadow`.
@immutable
class KiraEffects extends ThemeExtension<KiraEffects> {
  const KiraEffects({
    required this.glowMagenta,
    required this.glowMagentaStrong,
    required this.glowCyan,
    required this.glowGold,
    required this.elevationCard,
    required this.elevationFloat,
    required this.elevationOverlay,
  });

  /// The canonical KIRA effect set.
  static const KiraEffects standard = KiraEffects(
    glowMagenta: [
      BoxShadow(
        color: Color(0x66FF2E8A), // magenta500 @ 40%
        offset: Offset(0, 4),
        blurRadius: 24,
      ),
    ],
    glowMagentaStrong: [
      BoxShadow(
        color: Color(0x8CFF2E8A), // magenta500 @ 55%
        blurRadius: 24,
      ),
      BoxShadow(
        color: Color(0x66FF2E8A), // magenta500 @ 40%
        offset: Offset(0, 4),
        blurRadius: 24,
      ),
    ],
    glowCyan: [
      BoxShadow(
        color: Color(0x7300E5FF), // cyan500 @ 45%
        blurRadius: 22,
      ),
    ],
    glowGold: [
      BoxShadow(
        color: Color(0x66FFD64F), // gold500 @ 40%
        blurRadius: 20,
      ),
    ],
    elevationCard: [
      BoxShadow(
        color: Color(0x66000000), // black @ 40%
        offset: Offset(0, 8),
        blurRadius: 24,
        spreadRadius: -4,
      ),
    ],
    elevationFloat: [
      BoxShadow(
        color: Color(0x8C000000), // black @ 55%
        offset: Offset(0, 30),
        blurRadius: 60,
        spreadRadius: -8,
      ),
    ],
    elevationOverlay: [
      BoxShadow(
        color: Color(0x99000000), // black @ 60%
        offset: Offset(0, 16),
        blurRadius: 48,
        spreadRadius: -6,
      ),
    ],
  );

  /// Soft magenta neon glow.
  final List<BoxShadow> glowMagenta;

  /// Intense magenta neon glow (two-layer) — for primary CTAs / hero.
  final List<BoxShadow> glowMagentaStrong;

  /// Cyan neon glow.
  final List<BoxShadow> glowCyan;

  /// Gold neon glow.
  final List<BoxShadow> glowGold;

  /// Card depth.
  final List<BoxShadow> elevationCard;

  /// Floating element depth (menus, FAB).
  final List<BoxShadow> elevationFloat;

  /// Modal / overlay depth.
  final List<BoxShadow> elevationOverlay;

  @override
  KiraEffects copyWith({
    List<BoxShadow>? glowMagenta,
    List<BoxShadow>? glowMagentaStrong,
    List<BoxShadow>? glowCyan,
    List<BoxShadow>? glowGold,
    List<BoxShadow>? elevationCard,
    List<BoxShadow>? elevationFloat,
    List<BoxShadow>? elevationOverlay,
  }) {
    return KiraEffects(
      glowMagenta: glowMagenta ?? this.glowMagenta,
      glowMagentaStrong: glowMagentaStrong ?? this.glowMagentaStrong,
      glowCyan: glowCyan ?? this.glowCyan,
      glowGold: glowGold ?? this.glowGold,
      elevationCard: elevationCard ?? this.elevationCard,
      elevationFloat: elevationFloat ?? this.elevationFloat,
      elevationOverlay: elevationOverlay ?? this.elevationOverlay,
    );
  }

  @override
  KiraEffects lerp(covariant KiraEffects? other, double t) {
    if (other == null) return this;
    return KiraEffects(
      glowMagenta: BoxShadow.lerpList(glowMagenta, other.glowMagenta, t)!,
      glowMagentaStrong: BoxShadow.lerpList(
        glowMagentaStrong,
        other.glowMagentaStrong,
        t,
      )!,
      glowCyan: BoxShadow.lerpList(glowCyan, other.glowCyan, t)!,
      glowGold: BoxShadow.lerpList(glowGold, other.glowGold, t)!,
      elevationCard: BoxShadow.lerpList(elevationCard, other.elevationCard, t)!,
      elevationFloat: BoxShadow.lerpList(
        elevationFloat,
        other.elevationFloat,
        t,
      )!,
      elevationOverlay: BoxShadow.lerpList(
        elevationOverlay,
        other.elevationOverlay,
        t,
      )!,
    );
  }
}
