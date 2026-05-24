import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeBuilder extends StatelessWidget {
  final Widget Function(ThemeData lightTheme, ThemeData darkTheme) builder;

  const AppThemeBuilder({
    required this.builder,
    super.key,
  });

  /// Default seed color for the app
  static const seedColor = Color(0xFF01677D);

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
    builder: (lightDynamic, darkDynamic) {
      final textTheme = Theme.of(context).textTheme;
      final lightScheme = _lightScheme(lightDynamic);
      final darkScheme = _darkScheme(darkDynamic);
      final lightTextTheme = _textTheme(textTheme, lightScheme);
      final darkTextTheme = _textTheme(textTheme, darkScheme);

      var lightTheme = ThemeData.from(
        colorScheme: lightScheme,
        textTheme: lightTextTheme,
        useMaterial3: true,
      );
      var darkTheme = ThemeData.from(
        colorScheme: darkScheme,
        textTheme: darkTextTheme,
        useMaterial3: true,
      );

      lightTheme = _setComponentsTheme(lightTheme);
      darkTheme = _setComponentsTheme(darkTheme);
      return builder(lightTheme, darkTheme);
    },
  );

  ColorScheme _lightScheme(ColorScheme? lightDynamic) {
    final defaultScheme = ColorScheme.fromSeed(seedColor: seedColor);
    return lightDynamic ?? defaultScheme;
  }

  ColorScheme _darkScheme(ColorScheme? darkDynamic) {
    final defaultScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    return darkDynamic ?? defaultScheme;
  }

  TextTheme _textTheme(TextTheme textTheme, ColorScheme colorScheme) {
    final newTextTheme = textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );
    return newTextTheme;
  }

  ThemeData _setComponentsTheme(ThemeData theme) => theme.copyWith(
    navigationRailTheme: _navigationRailTheme(theme.colorScheme),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(theme.colorScheme),
    pageTransitionsTheme: _pageTransitionsTheme(),
  );

  /// Theme from https://m3.material.io/components/navigation-rail/specs
  NavigationRailThemeData _navigationRailTheme(ColorScheme scheme) =>
      NavigationRailThemeData(
        elevation: 0,
        minWidth: 96,
        minExtendedWidth: 220,
        backgroundColor: scheme.surface,
        selectedIconTheme: IconThemeData(
          size: 24,
          color: scheme.onSecondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: scheme.onSurfaceVariant,
        ),
        indicatorColor: scheme.secondaryContainer,
        indicatorShape: const StadiumBorder(),
        useIndicator: true,
        groupAlignment: 0,
        labelType: NavigationRailLabelType.none,
        selectedLabelTextStyle: TextStyle(
          color: scheme.secondary,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: scheme.onSurfaceVariant,
        ),
      );

  /// Theme from https://m3.material.io/components/navigation-bar/specs
  BottomNavigationBarThemeData _bottomNavigationBarTheme(ColorScheme scheme) =>
      BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: scheme.surfaceContainer,
        selectedLabelStyle: TextStyle(
          color: scheme.secondary,
        ),
        unselectedLabelStyle: TextStyle(
          color: scheme.onSurfaceVariant,
        ),
        selectedIconTheme: IconThemeData(
          size: 24,
          color: scheme.secondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: scheme.onSurfaceVariant,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        enableFeedback: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      );

  PageTransitionsTheme _pageTransitionsTheme() {
    const builders = <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
    };
    return const PageTransitionsTheme(builders: builders);
  }
}
