import 'package:flutter/widgets.dart';

/// Raw color primitives of the KIRA design system.
///
/// These are the literal palette values (Figma collection `Primitives`).
/// Components should not reference these directly — use the semantic
/// `KiraColors` tokens instead. Primitives exist to build the semantic layer.
abstract final class KiraPalette {
  // Ink — near-black surfaces (dark cyberpunk base).
  static const Color ink950 = Color(0xFF08070D);
  static const Color ink900 = Color(0xFF131220);
  static const Color ink850 = Color(0xFF1B1A28);
  static const Color ink800 = Color(0xFF262534);
  static const Color ink700 = Color(0xFF353347);

  // Paper — foreground / text.
  static const Color paper0 = Color(0xFFFFFFFF);
  static const Color paper100 = Color(0xFFF4F3F7);
  static const Color paper300 = Color(0xFF9893AB);
  static const Color paper500 = Color(0xFF7E7A93);

  // Magenta — primary neon accent.
  static const Color magenta300 = Color(0xFFFF7AB5);
  static const Color magenta400 = Color(0xFFFF5AA0);
  static const Color magenta500 = Color(0xFFFF2E8A);
  static const Color magenta600 = Color(0xFFE01F74);
  static const Color magenta700 = Color(0xFFB3155B);

  // Cyan — secondary neon accent.
  static const Color cyan300 = Color(0xFF6FF0FF);
  static const Color cyan500 = Color(0xFF00E5FF);
  static const Color cyan600 = Color(0xFF00B8CC);
  static const Color cyan700 = Color(0xFF018299);

  // Gold — tertiary accent.
  static const Color gold300 = Color(0xFFFFE28A);
  static const Color gold500 = Color(0xFFFFD64F);
  static const Color gold600 = Color(0xFFE6B82E);

  // Support — semantic status colors.
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFFB7185);

  /// Ink used on top of bright accent fills (near-black).
  static const Color onAccent = Color(0xFF0A0510);

  // Alpha — translucent overlays. ARGB with baked opacity.
  static const Color whiteA07 = Color(0x12FFFFFF);
  static const Color whiteA10 = Color(0x1AFFFFFF);
  static const Color whiteA14 = Color(0x24FFFFFF);
  static const Color whiteA18 = Color(0x2EFFFFFF);
  static const Color blackA50 = Color(0x80000000);
  static const Color blackA55 = Color(0x8C000000);
  static const Color magentaA15 = Color(0x26FF2E8A);
  static const Color magentaA50 = Color(0x80FF2E8A);
}
