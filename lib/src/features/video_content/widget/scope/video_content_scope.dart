import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget_model/video_content_all_wm.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget_model/video_content_random_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

/// Scope widget for video content feature.
///
/// Provides access to video content dependencies through the widget tree.
class VideoContentScope extends StatelessWidget {
  /// Child widget to be wrapped with the scope
  final Widget child;

  /// Creates a new instance of [VideoContentScope].
  ///
  /// [child] - The child widget to be wrapped with the scope
  const VideoContentScope({
    required this.child,
    super.key,
  });

  static VideoContentContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<VideoContentContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'VideoContentContainerOutputScope',
    );
  }

  static VideoContentSM videoContentRandomSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoContentRandomSM;

  static VideoContentSM videoContentAllSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoContentAllSM;

  static IVideoContentRandomWM videoContentRandomWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoContentRandomWM;

  static IVideoContentAllWM videoContentAllWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).videoContentAllWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<VideoContentContainerOutputScope>(
        holder: AppScope.containerOf(context).videoContentContainerHolder,
        child: ScopeBuilder<VideoContentContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
