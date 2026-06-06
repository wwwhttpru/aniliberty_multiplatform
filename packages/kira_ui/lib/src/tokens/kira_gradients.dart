import 'package:flutter/material.dart';
import 'package:kira_ui/src/tokens/kira_palette.dart';

/// Gradient tokens of the KIRA design system.
///
/// The signature magenta→cyan gradient is reserved for the primary CTA and the
/// logo (per design discipline). Direction is the top-left → bottom-right
/// diagonal, matched to the primary `Button` paint in Figma (45° transform).
/// Figma stores gradients as paints, not variables, so this is the canonical
/// Dart definition of the token.
@immutable
class KiraGradients extends ThemeExtension<KiraGradients> {
  const KiraGradients({required this.accent});

  /// The canonical KIRA gradient set.
  static const KiraGradients standard = KiraGradients(
    accent: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [KiraPalette.magenta500, KiraPalette.cyan500],
    ),
  );

  /// Signature magenta→cyan brand gradient.
  final LinearGradient accent;

  @override
  KiraGradients copyWith({LinearGradient? accent}) {
    return KiraGradients(accent: accent ?? this.accent);
  }

  @override
  KiraGradients lerp(covariant KiraGradients? other, double t) {
    if (other == null) return this;
    return KiraGradients(
      accent: LinearGradient.lerp(accent, other.accent, t)!,
    );
  }
}
