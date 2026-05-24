// ignore_for_file: comment_references

import 'package:aniliberty_multiplatform/src/core/adaptive/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

class PlatformPageSheetFactory<T> implements PageFactory<T> {
  /// Stores a list of captured [InheritedTheme]s that are wrapped around the
  /// bottom sheet.
  ///
  /// Consider setting this attribute when the [ModalBottomSheetRoute]
  /// is created through [Navigator.push] and its friends.
  final CapturedThemes? capturedThemes;

  /// Specifies whether this is a route for a bottom sheet that will utilize
  /// [DraggableScrollableSheet].
  ///
  /// Consider setting this parameter to true if this bottom sheet has
  /// a scrollable child, such as a [ListView] or a [GridView],
  /// to have the bottom sheet be draggable.
  final bool isScrollControlled;

  /// The max height constraint ratio for the bottom sheet
  /// when [isScrollControlled] is set to false,
  /// no ratio will be applied when [isScrollControlled] is set to true.
  ///
  /// Defaults to 9 / 16.
  final double scrollControlDisabledMaxHeightRatio;

  /// The bottom sheet's background color.
  ///
  /// Defines the bottom sheet's [Material.color].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material.
  ///
  /// Defaults to 0, must not be negative.
  final double? elevation;

  /// The shape of the bottom sheet.
  ///
  /// Defines the bottom sheet's [Material.shape].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defines the bottom sheet's [Material.clipBehavior].
  ///
  /// Use this property to enable clipping of content when the bottom sheet has
  /// a custom [shape] and the content can extend past this shape. For example,
  /// a bottom sheet with rounded corners and an edge-to-edge [Image] at the
  /// top.
  ///
  /// If this property is null, the [BottomSheetThemeData.clipBehavior] of
  /// [ThemeData.bottomSheetTheme] is used. If that's null, the behavior defaults to [Clip.none]
  /// will be [Clip.none].
  final Clip? clipBehavior;

  /// Defines minimum and maximum sizes for a [BottomSheet].
  ///
  /// If null, the ambient [ThemeData.bottomSheetTheme]'s
  /// [BottomSheetThemeData.constraints] will be used. If that
  /// is null and [ThemeData.useMaterial3] is true, then the bottom sheet
  /// will have a max width of 640dp. If [ThemeData.useMaterial3] is false, then
  /// the bottom sheet's size will be constrained by its parent
  /// (usually a [Scaffold]). In this case, consider limiting the width by
  /// setting smaller constraints for large screens.
  ///
  /// If constraints are specified (either in this property or in the
  /// theme), the bottom sheet will be aligned to the bottom-center of
  /// the available space. Otherwise, no alignment is applied.
  final BoxConstraints? constraints;

  /// Specifies the color of the modal barrier that darkens everything below the
  /// bottom sheet.
  ///
  /// Defaults to `Colors.black54` if not provided.
  final Color? modalBarrierColor;

  /// Specifies whether the bottom sheet will be dismissed
  /// when user taps on the scrim.
  ///
  /// If true, the bottom sheet will be dismissed when user taps on the scrim.
  ///
  /// Defaults to true.
  final bool isDismissible;

  /// Specifies whether the bottom sheet can be dragged up and down
  /// and dismissed by swiping downwards.
  ///
  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// This applies to the content below the drag handle, if showDragHandle is true.
  ///
  /// Defaults is true.
  final bool enableDrag;

  /// Specifies whether a drag handle is shown.
  ///
  /// The drag handle appears at the top of the bottom sheet. The default color is
  /// [ColorScheme.onSurfaceVariant] with an opacity of 0.4 and can be customized
  /// using dragHandleColor. The default size is `Size(32,4)` and can be customized
  /// with dragHandleSize.
  ///
  /// If null, then the value of [BottomSheetThemeData.showDragHandle] is used. If
  /// that is also null, defaults to false.
  final bool? showDragHandle;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController? transitionAnimationController;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Whether to avoid system intrusions on the top, left, and right.
  ///
  /// If true, a [SafeArea] is inserted to keep the bottom sheet away from
  /// system intrusions at the top, left, and right sides of the screen.
  ///
  /// If false, the bottom sheet will extend through any system intrusions
  /// at the top, left, and right.
  ///
  /// If false, then moreover [MediaQuery.removePadding] will be used
  /// to remove top padding, so that a [SafeArea] widget inside the bottom
  /// sheet will have no effect at the top edge. If this is undesired, consider
  /// setting [useSafeArea] to true. Alternatively, wrap the [SafeArea] in a
  /// [MediaQuery] that restates an ambient [MediaQueryData] from outside [builder].
  ///
  /// In either case, the bottom sheet extends all the way to the bottom of
  /// the screen, including any system intrusions.
  ///
  /// The default is false.
  final bool useSafeArea;

  /// Used to override the modal bottom sheet animation duration and reverse
  /// animation duration.
  ///
  /// If [AnimationStyle.duration] is provided, it will be used to override
  /// the modal bottom sheet animation duration in the underlying
  /// [BottomSheet.createAnimationController].
  ///
  /// If [AnimationStyle.reverseDuration] is provided, it will be used to
  /// override the modal bottom sheet reverse animation duration in the
  /// underlying [BottomSheet.createAnimationController].
  ///
  /// To disable the modal bottom sheet animation, use [AnimationStyle.noAnimation].
  final AnimationStyle? sheetAnimationStyle;

  /// {@template flutter.material.ModalBottomSheetRoute.barrierOnTapHint}
  /// The semantic hint text that informs users what will happen if they
  /// tap on the widget. Announced in the format of 'Double tap to ...'.
  ///
  /// If the field is null, the default hint will be used, which results in
  /// announcement of 'Double tap to activate'.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], which uses this field as onTapHint when it has an onTap action.
  final String? barrierOnTapHint;

  /// {@template flutter.widgets.ModalRoute.barrierLabel}
  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different label,
  /// either [changedInternalState] or [changedExternalState] should
  /// be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], the widget that implements this feature.
  final String? barrierLabel;

  /// When the route state is updated, request focus if the current route is at the top.
  ///
  /// If not provided in the constructor, [Navigator.requestFocus] is used instead.
  final bool? requestFocus;

  /// Restoration ID to save and restore the state of the [Route] configured by
  /// this page.
  ///
  /// If no restoration ID is provided, the [Route] will not restore its state.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  /// Called after a pop on the associated route was handled.
  ///
  /// It's not possible to prevent the pop from happening at the time that this
  /// method is called; the pop has already happened. Use [canPop] to
  /// disable pops in advance.
  ///
  /// This will still be called even when the pop is canceled. A pop is canceled
  /// when the associated [Route.popDisposition] returns false, or when
  /// [canPop] is set to false. The `didPop` parameter indicates whether or not
  /// the back navigation actually happened successfully.
  final PopInvokedWithResultCallback<T>? onPopInvoked;

  /// When false, blocks the associated route from being popped.
  ///
  /// If this is set to false for first page in the Navigator. It prevents
  /// Flutter app from exiting.
  ///
  /// If there are any [PopScope] widgets in a route's widget subtree,
  /// each of their `canPop` must be `true`, in addition to this canPop, in
  /// order for the route to be able to pop.
  final bool canPop;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@template flutter.widgets.RawDialogRoute.fullscreenDialog}
  /// Whether this route is a full-screen dialog.
  ///
  /// In Material and Cupertino, being fullscreen has the effects of making
  /// the app bars have a close button instead of a back button. On
  /// iOS, dialogs transitions animate differently and are also not closeable
  /// with the back swipe gesture.
  /// {@endtemplate}
  final bool fullscreenDialog;

  const PlatformPageSheetFactory({
    this.capturedThemes,
    this.isScrollControlled = false,
    this.scrollControlDisabledMaxHeightRatio = 9 / 16,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.showDragHandle,
    this.transitionAnimationController,
    this.anchorPoint,
    this.useSafeArea = false,
    this.sheetAnimationStyle,
    this.barrierOnTapHint,
    this.barrierLabel,
    this.requestFocus,
    this.restorationId,
    this.onPopInvoked,
    this.canPop = true,
    this.traversalEdgeBehavior,
    this.fullscreenDialog = false,
  });

  @override
  Page<T> call(
    BuildContext context,
    RouteNode routeNode,
    LocalKey key,
    Widget child,
  ) {
    final platformType = context.platformType;

    if (platformType.isMobile) {
      return PagesFactory<T>.modalBottomSheet(
        isScrollControlled: isScrollControlled,
        capturedThemes: capturedThemes,
        barrierLabel: barrierLabel,
        barrierOnTapHint: barrierOnTapHint,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        modalBarrierColor: modalBarrierColor,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        scrollControlDisabledMaxHeightRatio:
            scrollControlDisabledMaxHeightRatio,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
        useSafeArea: useSafeArea,
        restorationId: restorationId,
        canPop: canPop,
        onPopInvoked: onPopInvoked ?? (_, __) {},
      ).call(context, routeNode, key, child);
    }

    return YxDialogPageFactory<T>(
      themes: capturedThemes,
      barrierColor: modalBarrierColor,
      barrierDismissible: isDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      requestFocus: requestFocus,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
      fullscreenDialog: fullscreenDialog,
      animationStyle: sheetAnimationStyle,
      restorationId: restorationId,
      canPop: canPop,
      onPopInvoked: onPopInvoked ?? (_, __) {},
    ).call(context, routeNode, key, child);
  }
}

class YxDialogPageFactory<T> implements PageFactory<T> {
  /// Stores a list of captured [InheritedTheme]s that are wrapped around the
  /// bottom sheet.
  ///
  /// Consider setting this attribute when the [ModalBottomSheetRoute]
  /// is created through [Navigator.push] and its friends.
  final CapturedThemes? themes;

  /// Specifies the color of the modal barrier that darkens everything below the
  /// dialog.
  ///
  /// Defaults to `Colors.black54` if not provided.
  final Color? barrierColor;

  /// Specifies whether the dialog will be dismissed
  /// when user taps on the barrier.
  ///
  /// If true, the dialog will be dismissed when user taps on the scrim.
  ///
  /// Defaults to true.
  final bool barrierDismissible;

  /// {@macro flutter.widgets.ModalRoute.barrierLabel}
  final String? barrierLabel;

  /// Whether to avoid system intrusions on the top, left, and right.
  ///
  /// If true, a [SafeArea] is inserted to keep the dialog away from
  /// system intrusions at the top, left, and right sides of the screen.
  ///
  /// If false, the dialog will extend through any system intrusions
  /// at the top, left, and right.
  ///
  /// If false, then moreover [MediaQuery.removePadding] will be used
  /// to remove top padding, so that a [SafeArea] widget inside the dialog
  /// will have no effect at the top edge. If this is undesired, consider
  /// setting [useSafeArea] to true. Alternatively, wrap the [SafeArea] in a
  /// [MediaQuery] that restates an ambient [MediaQueryData] from outside [builder].
  final bool useSafeArea;

  /// When the route state is updated, request focus if the current route is at the top.
  ///
  /// If not provided in the constructor, [Navigator.requestFocus] is used instead.
  final bool? requestFocus;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@template flutter.widgets.RawDialogRoute.fullscreenDialog}
  /// Whether this route is a full-screen dialog.
  ///
  /// In Material and Cupertino, being fullscreen has the effects of making
  /// the app bars have a close button instead of a back button. On
  /// iOS, dialogs transitions animate differently and are also not closeable
  /// with the back swipe gesture.
  /// {@endtemplate}
  final bool fullscreenDialog;

  /// Used to override the modal dialog animation duration and reverse
  /// animation duration.
  ///
  /// If [AnimationStyle.duration] is provided, it will be used to override
  /// the modal dialog animation duration in the underlying
  /// [DialogRoute.createAnimationController].
  ///
  /// If [AnimationStyle.reverseDuration] is provided, it will be used to
  /// override the modal dialog reverse animation duration in the
  /// underlying [DialogRoute.createAnimationController].
  ///
  /// To disable the modal dialog animation, use [AnimationStyle.noAnimation].
  final AnimationStyle? animationStyle;

  /// Restoration ID to save and restore the state of the [Route] configured by
  /// this page.
  ///
  /// If no restoration ID is provided, the [Route] will not restore its state.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  /// Called after a pop on the associated route was handled.
  ///
  /// It's not possible to prevent the pop from happening at the time that this
  /// method is called; the pop has already happened. Use [canPop] to
  /// disable pops in advance.
  ///
  /// This will still be called even when the pop is canceled. A pop is canceled
  /// when the associated [Route.popDisposition] returns false, or when
  /// [canPop] is set to false. The `didPop` parameter indicates whether or not
  /// the back navigation actually happened successfully.
  final PopInvokedWithResultCallback<T>? onPopInvoked;

  /// When false, blocks the associated route from being popped.
  ///
  /// If this is set to false for first page in the Navigator. It prevents
  /// Flutter app from exiting.
  ///
  /// If there are any [PopScope] widgets in a route's widget subtree,
  /// each of their `canPop` must be `true`, in addition to this canPop, in
  /// order for the route to be able to pop.
  final bool canPop;

  const YxDialogPageFactory({
    this.themes,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.requestFocus,
    this.anchorPoint,
    this.traversalEdgeBehavior,
    this.fullscreenDialog = false,
    this.animationStyle,
    this.restorationId,
    this.canPop = true,
    this.onPopInvoked,
  });

  @override
  Page<T> call(
    BuildContext context,
    RouteNode routeNode,
    LocalKey key,
    Widget child,
  ) => DialogPage<T>(
    key: key,
    name: routeNode.route.id,
    arguments: routeNode.arguments,
    builder: (context) => child,
    themes: themes,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    requestFocus: requestFocus,
    anchorPoint: anchorPoint,
    traversalEdgeBehavior: traversalEdgeBehavior,
    fullscreenDialog: fullscreenDialog,
    animationStyle: animationStyle,
    restorationId: restorationId,
    canPop: canPop,
    onPopInvoked: onPopInvoked ?? (_, __) {},
  );
}

class DialogPage<T> extends Page<T> {
  /// A builder for the contents of the dialog.
  ///
  /// The dialog will wrap the widget produced by this builder in a
  /// [Material] widget.
  final WidgetBuilder builder;

  /// Stores a list of captured [InheritedTheme]s that are wrapped around the
  /// bottom sheet.
  ///
  /// Consider setting this attribute when the [ModalBottomSheetRoute]
  /// is created through [Navigator.push] and its friends.
  final CapturedThemes? themes;

  /// Specifies the color of the modal barrier that darkens everything below the
  /// dialog.
  ///
  /// Defaults to `Colors.black54` if not provided.
  final Color? barrierColor;

  /// Specifies whether the dialog will be dismissed
  /// when user taps on the barrier.
  ///
  /// If true, the dialog will be dismissed when user taps on the scrim.
  ///
  /// Defaults to true.
  final bool barrierDismissible;

  /// {@macro flutter.widgets.ModalRoute.barrierLabel}
  final String? barrierLabel;

  /// Whether to avoid system intrusions on the top, left, and right.
  ///
  /// If true, a [SafeArea] is inserted to keep the dialog away from
  /// system intrusions at the top, left, and right sides of the screen.
  ///
  /// If false, the dialog will extend through any system intrusions
  /// at the top, left, and right.
  ///
  /// If false, then moreover [MediaQuery.removePadding] will be used
  /// to remove top padding, so that a [SafeArea] widget inside the dialog
  /// will have no effect at the top edge. If this is undesired, consider
  /// setting [useSafeArea] to true. Alternatively, wrap the [SafeArea] in a
  /// [MediaQuery] that restates an ambient [MediaQueryData] from outside [builder].
  final bool useSafeArea;

  /// When the route state is updated, request focus if the current route is at the top.
  ///
  /// If not provided in the constructor, [Navigator.requestFocus] is used instead.
  final bool? requestFocus;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@template flutter.widgets.RawDialogRoute.fullscreenDialog}
  /// Whether this route is a full-screen dialog.
  ///
  /// In Material and Cupertino, being fullscreen has the effects of making
  /// the app bars have a close button instead of a back button. On
  /// iOS, dialogs transitions animate differently and are also not closeable
  /// with the back swipe gesture.
  /// {@endtemplate}
  final bool fullscreenDialog;

  /// Used to override the modal dialog animation duration and reverse
  /// animation duration.
  ///
  /// If [AnimationStyle.duration] is provided, it will be used to override
  /// the modal dialog animation duration in the underlying
  /// [DialogRoute.createAnimationController].
  ///
  /// If [AnimationStyle.reverseDuration] is provided, it will be used to
  /// override the modal dialog reverse animation duration in the
  /// underlying [DialogRoute.createAnimationController].
  ///
  /// To disable the modal dialog animation, use [AnimationStyle.noAnimation].
  final AnimationStyle? animationStyle;

  const DialogPage({
    required super.key,
    required super.name,
    required super.arguments,
    required this.builder,
    this.themes,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.requestFocus,
    this.anchorPoint,
    this.traversalEdgeBehavior,
    this.fullscreenDialog = false,
    this.animationStyle,
    super.restorationId,
    super.canPop,
    super.onPopInvoked,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    builder: builder,
    themes: themes,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    settings: this,
    requestFocus: requestFocus,
    anchorPoint: anchorPoint,
    traversalEdgeBehavior: traversalEdgeBehavior,
    fullscreenDialog: fullscreenDialog,
    animationStyle: animationStyle,
  );
}
