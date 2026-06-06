import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Sizing tokens of the KIRA design system (Figma collection `Sizing`):
/// corner radii, spacing scale and stroke widths.
@immutable
class KiraDimensions extends ThemeExtension<KiraDimensions> {
  const KiraDimensions({
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radius2xl,
    required this.radius3xl,
    required this.radiusFull,
    required this.space2xs,
    required this.spaceXs,
    required this.spaceSm,
    required this.spaceMd,
    required this.spaceLg,
    required this.spaceXl,
    required this.space2xl,
    required this.space3xl,
    required this.strokeHairline,
    required this.strokeThick,
  });

  /// The canonical KIRA sizing scale.
  static const KiraDimensions standard = KiraDimensions(
    radiusXs: 4,
    radiusSm: 10,
    radiusMd: 12,
    radiusLg: 14,
    radiusXl: 16,
    radius2xl: 18,
    radius3xl: 22,
    radiusFull: 999,
    space2xs: 4,
    spaceXs: 8,
    spaceSm: 12,
    spaceMd: 16,
    spaceLg: 24,
    spaceXl: 32,
    space2xl: 48,
    space3xl: 64,
    strokeHairline: 1,
    strokeThick: 2,
  );

  // Corner radii.
  final double radiusXs;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;
  final double radius2xl;
  final double radius3xl;

  /// Pill / fully-rounded radius.
  final double radiusFull;

  // Spacing scale.
  final double space2xs;
  final double spaceXs;
  final double spaceSm;
  final double spaceMd;
  final double spaceLg;
  final double spaceXl;
  final double space2xl;
  final double space3xl;

  // Stroke widths.
  final double strokeHairline;
  final double strokeThick;

  @override
  KiraDimensions copyWith({
    double? radiusXs,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
    double? radius2xl,
    double? radius3xl,
    double? radiusFull,
    double? space2xs,
    double? spaceXs,
    double? spaceSm,
    double? spaceMd,
    double? spaceLg,
    double? spaceXl,
    double? space2xl,
    double? space3xl,
    double? strokeHairline,
    double? strokeThick,
  }) {
    return KiraDimensions(
      radiusXs: radiusXs ?? this.radiusXs,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusXl: radiusXl ?? this.radiusXl,
      radius2xl: radius2xl ?? this.radius2xl,
      radius3xl: radius3xl ?? this.radius3xl,
      radiusFull: radiusFull ?? this.radiusFull,
      space2xs: space2xs ?? this.space2xs,
      spaceXs: spaceXs ?? this.spaceXs,
      spaceSm: spaceSm ?? this.spaceSm,
      spaceMd: spaceMd ?? this.spaceMd,
      spaceLg: spaceLg ?? this.spaceLg,
      spaceXl: spaceXl ?? this.spaceXl,
      space2xl: space2xl ?? this.space2xl,
      space3xl: space3xl ?? this.space3xl,
      strokeHairline: strokeHairline ?? this.strokeHairline,
      strokeThick: strokeThick ?? this.strokeThick,
    );
  }

  @override
  KiraDimensions lerp(covariant KiraDimensions? other, double t) {
    if (other == null) return this;
    return KiraDimensions(
      radiusXs: lerpDouble(radiusXs, other.radiusXs, t)!,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t)!,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t)!,
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t)!,
      radiusXl: lerpDouble(radiusXl, other.radiusXl, t)!,
      radius2xl: lerpDouble(radius2xl, other.radius2xl, t)!,
      radius3xl: lerpDouble(radius3xl, other.radius3xl, t)!,
      radiusFull: lerpDouble(radiusFull, other.radiusFull, t)!,
      space2xs: lerpDouble(space2xs, other.space2xs, t)!,
      spaceXs: lerpDouble(spaceXs, other.spaceXs, t)!,
      spaceSm: lerpDouble(spaceSm, other.spaceSm, t)!,
      spaceMd: lerpDouble(spaceMd, other.spaceMd, t)!,
      spaceLg: lerpDouble(spaceLg, other.spaceLg, t)!,
      spaceXl: lerpDouble(spaceXl, other.spaceXl, t)!,
      space2xl: lerpDouble(space2xl, other.space2xl, t)!,
      space3xl: lerpDouble(space3xl, other.space3xl, t)!,
      strokeHairline: lerpDouble(strokeHairline, other.strokeHairline, t)!,
      strokeThick: lerpDouble(strokeThick, other.strokeThick, t)!,
    );
  }
}
