import 'package:flutter/material.dart';
import 'package:kira_ui/src/tokens/kira_colors.dart';
import 'package:kira_ui/src/tokens/kira_dimensions.dart';
import 'package:kira_ui/src/tokens/kira_effects.dart';
import 'package:kira_ui/src/tokens/kira_gradients.dart';
import 'package:kira_ui/src/tokens/kira_palette.dart';
import 'package:kira_ui/src/tokens/kira_typography.dart';

/// Builds the KIRA [ThemeData] — a single dark theme wiring the Material color
/// scheme, text theme and all KIRA [ThemeExtension] tokens.
///
/// Access tokens via `context.kiraColors`, `context.kiraText`, etc.
ThemeData buildKiraTheme() {
  const colors = KiraColors.dark;
  const type = KiraTypography.standard;

  const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: KiraPalette.magenta500,
    onPrimary: KiraPalette.onAccent,
    secondary: KiraPalette.cyan500,
    onSecondary: KiraPalette.onAccent,
    tertiary: KiraPalette.gold500,
    onTertiary: KiraPalette.onAccent,
    surface: KiraPalette.ink900,
    onSurface: KiraPalette.paper100,
    error: KiraPalette.danger,
    onError: KiraPalette.onAccent,
  );

  final textTheme = TextTheme(
    displayLarge: type.display2xl,
    displayMedium: type.displayXl,
    displaySmall: type.displayLg,
    headlineMedium: type.displayMd,
    titleLarge: type.titleLg,
    titleMedium: type.titleMd,
    bodyLarge: type.bodyLg,
    bodyMedium: type.bodyMd,
    bodySmall: type.bodySm,
    labelLarge: type.labelButton,
    labelSmall: type.labelSmall,
  ).apply(bodyColor: colors.text, displayColor: colors.text);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.bg,
    canvasColor: colors.bg,
    fontFamily: KiraFontFamily.body,
    textTheme: textTheme,
    extensions: const [
      KiraColors.dark,
      KiraTypography.standard,
      KiraDimensions.standard,
      KiraEffects.standard,
      KiraGradients.standard,
    ],
  );
}

/// Ergonomic access to KIRA tokens from a [BuildContext].
///
/// Falls back to the canonical token sets if the theme is missing the
/// extension, so widgets never crash on a misconfigured theme.
extension KiraThemeContext on BuildContext {
  /// Semantic color tokens.
  KiraColors get kiraColors =>
      Theme.of(this).extension<KiraColors>() ?? KiraColors.dark;

  /// Typography tokens.
  KiraTypography get kiraText =>
      Theme.of(this).extension<KiraTypography>() ?? KiraTypography.standard;

  /// Sizing tokens (radii, spacing, strokes).
  KiraDimensions get kiraDimensions =>
      Theme.of(this).extension<KiraDimensions>() ?? KiraDimensions.standard;

  /// Shadow / glow tokens.
  KiraEffects get kiraEffects =>
      Theme.of(this).extension<KiraEffects>() ?? KiraEffects.standard;

  /// Gradient tokens.
  KiraGradients get kiraGradients =>
      Theme.of(this).extension<KiraGradients>() ?? KiraGradients.standard;
}
