import 'package:aniliberty_multiplatform/src/core/adaptive/adaptive_info.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/platform_type.dart';
import 'package:aniliberty_multiplatform/src/core/adaptive/window_size.dart';
import 'package:flutter/widgets.dart';

class AdaptiveScope extends StatelessWidget {
  final Widget child;

  const AdaptiveScope({required this.child, super.key});

  static AdaptiveInfo of(BuildContext context, {bool listen = true}) {
    _InheritedAdaptiveWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<_InheritedAdaptiveWidget>();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_InheritedAdaptiveWidget>();
    }

    if (widget == null) {
      throw Exception('AdaptiveScope not found');
    }

    return widget.info;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _InheritedAdaptiveWidget(
      info: AdaptiveInfo(
        windowSize: WindowSize(size),
        platformType: PlatformType.getCurrentPlatform(),
      ),
      child: child,
    );
  }
}

class _InheritedAdaptiveWidget extends InheritedWidget {
  /// The [AdaptiveInfo] provided by this scope.
  final AdaptiveInfo info;

  const _InheritedAdaptiveWidget({required this.info, required super.child});

  @override
  bool updateShouldNotify(_InheritedAdaptiveWidget oldWidget) =>
      info != oldWidget.info;
}
