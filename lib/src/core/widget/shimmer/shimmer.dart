import 'dart:developer' as developer;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// https://gist.github.com/PlugFox/87948692684838afc9efd839e83d0903
///
/// Use
/// ```dart
/// return Shimmer(
///   background: Theme.of(context).colorScheme.surface,
///   highlight: Theme.of(context).colorScheme.surfaceContainerHigh, // or surfaceContainerHighest
///   speed: 0.5,
///   stripe: 0.75,
/// );
/// ```
///
/// {@template shimmer}
/// A widget that creates a shimmering effect similar
/// to a moving highlight or reflection.
/// This is commonly used as a placeholder or loading indicator.
/// {@endtemplate}
/// {@category shaders}
class Shimmer extends LeafRenderObjectWidget {
  /// Creates a shimmer effect with the specified [highlight], [speed], [size], and [radius].
  /// {@macro stepper}
  const Shimmer({
    this.highlight = const ui.Color(0xFFEEEEEE),
    this.background = const Color(0xFFFFFFFF),
    this.speed = 1.0,
    this.size,
    this.radius,
    this.stripe,
    super.key,
  });

  /// The color of the shimmer effect.
  /// Defaults to a light color, slightly off-white.
  /// This color is used to create the shimmering highlight.
  final Color highlight;

  /// The background color of the shimmer effect.
  /// Better to use a background color of the parent widget.
  final Color background;

  /// The speed of the shimmer effect, where 1.0 is the default speed.
  final double speed;

  /// The size of the shimmer effect.
  /// If null, it will use the size of the parent widget.
  final Size? size;

  /// The radius for rounded corners of the shimmer effect.
  /// If null, it will not apply any rounded corners.
  final Radius? radius;

  /// Size of the stripe in the shimmer effect.
  /// One of the best choice is between 0.5 .. 1.0
  final double? stripe;

  @override
  RenderObject createRenderObject(BuildContext context) => ShimmerRenderObject(
    highlight:
        highlight, // Shimmer (primary) highlight color for the shimmer effect
    background:
        background, // Background (secondary) color for the shimmer effect
    speed: speed, // Speed of the shimmer effect multiplier
    size: size, // Size of the shimmer effect
    radius: radius, // Radius for rounded corners
    stripe: stripe, // Size of the stripe in the shimmer effect
  );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant ShimmerRenderObject renderObject,
  ) => renderObject.update(
    highlight:
        highlight, // Update shimmer (primary) highlight color for the shimmer effect
    background:
        background, // Update background (secondary) color for the shimmer effect
    speed: speed, // Speed of the shimmer effect multiplier
    size: size, // Size of the shimmer effect
    radius: radius, // Radius for rounded corners
    stripe: stripe, // Size of the stripe in the shimmer effect
  );
}

class ShimmerRenderObject extends RenderBox with WidgetsBindingObserver {
  ShimmerRenderObject({
    required this._highlight,
    required Color background,
    required this._speed,
    required this._size,
    required this._radius,
    required this._stripe,
  }) : _background = background,
       _paint = Paint() {
    _paint
      ..color = background
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver
      ..filterQuality = FilterQuality.low
      ..isAntiAlias = true;
  }

  Color _highlight;

  Color _background;

  double _speed;

  Size? _size;

  Radius? _radius;

  double? _stripe;

  final Paint _paint;

  /// Animation vsync ticker for the shimmer effect.
  Ticker? _animationTicker;

  void update({
    required Color highlight,
    required Color background,
    required double speed,
    required Size? size,
    required Radius? radius,
    required double? stripe,
  }) {
    if (size != _size) {
      markNeedsLayout();
    }
    _highlight = highlight;
    _background = background;
    _speed = speed;
    _size = size;
    _radius = radius;
    _stripe = stripe;
    _paint.color = background;
    markNeedsPaint();
  }

  Size _$size = Size.zero;

  @override
  Size get size => _$size;

  @override
  set size(Size value) {
    final prev = super.hasSize ? super.size : null;
    super.size = value;
    if (prev == value) return;
    _$size = value;
  }

  int _activeFlag = 0;

  @override
  bool get isRepaintBoundary => false;

  @override
  bool get alwaysNeedsCompositing => false;

  @override
  bool get sizedByParent => false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    const lifecycleFlag = 1 << 0; // Flag to indicate lifecycle changes
    if (state == AppLifecycleState.resumed) {
      _activeFlag &=
          ~lifecycleFlag; // Clear the active flag when the app is resumed
    } else {
      _activeFlag |= lifecycleFlag; // Set the active flag for other states
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _activeFlag &= ~(1 << 1); // Clear the active flag when attached
    WidgetsBinding.instance.addObserver(this);

    // Load the shader if it hasn't been loaded yet
    _ShimmerShaderManager.setShader(_paint);
    _animationTicker = Ticker(_onTick)..start();
  }

  Duration _elapsed = Duration.zero;
  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
    if (_activeFlag != 0) return; // Only update if the active flag is set
    // Perform the shimmer effect update logic here
    markNeedsPaint();
  }

  @override
  @protected
  void detach() {
    super.detach();
    _activeFlag |= 1 << 1; // Set the active flag when detached
    _animationTicker?.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  bool hitTestSelf(Offset position) => false;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      false;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => false;

  @override
  Size computeDryLayout(BoxConstraints constraints) => switch (_size) {
    final Size size => constraints.constrain(size),
    _ => constraints.biggest,
  };

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void performResize() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final size = this.size;
    if (size.isEmpty) return; // No need to paint if size is empty

    final canvas = context.canvas
      ..save()
      ..translate(offset.dx, offset.dy);

    // Clip the canvas to the size and radius if provided
    if (_radius case final Radius radius when radius != Radius.zero) {
      canvas.clipRRect(
        RRect.fromRectAndRadius(Offset.zero & size, _radius ?? Radius.zero),
      );
    } else {
      canvas.clipRect(Offset.zero & size);
    }

    if (_paint.shader case final ui.FragmentShader shader) {
      // If the shader is available, apply it to the paint
      final seed = _elapsed.inMicroseconds * _speed / 200000;
      _paint.shader = shader
        ..setFloat(0, size.width)
        ..setFloat(1, size.height)
        ..setFloat(2, seed)
        ..setFloat(3, _highlight.r)
        ..setFloat(4, _highlight.g)
        ..setFloat(5, _highlight.b)
        ..setFloat(6, _highlight.a)
        ..setFloat(7, _background.r)
        ..setFloat(8, _background.g)
        ..setFloat(9, _background.b)
        ..setFloat(10, _background.a)
        ..setFloat(11, _stripe ?? 0.75);
      canvas.drawRect(Offset.zero & size, _paint);
    } else {
      // If the shader is not available, draw a solid color
      canvas.drawRect(Offset.zero & size, _paint);
    }

    canvas.restore();
  }
}

abstract final class _ShimmerShaderManager {
  static ui.FragmentProgram? _$fragmentProgram;
  static final Future<ui.FragmentProgram?> _$loadfragmentProgramOnce =
      _$loadfragmentProgram();
  static Future<ui.FragmentProgram?> _$loadfragmentProgram() async {
    const asset = 'lib/src/core/widget/shimmer/shimmer.frag';
    try {
      final program = _$fragmentProgram = await ui.FragmentProgram.fromAsset(
        asset,
      ).timeout(const Duration(seconds: 5));
      return program;
      // ignore: avoid_catching_errors
    } on UnsupportedError {
      return null; // Thats fine for HTML Renderer and unsupported platforms.
    } catch (e, s) {
      developer.log(
        'Failed to load shader: $e',
        error: e,
        stackTrace: s,
        name: 'ui',
        level: 700,
      );
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: 'ui',
          context: ErrorDescription('Failed to load shimmer shader'),
        ),
      );
      return null;
    }
  }

  /// The shader to be used for the shimmer effect to be applied to the paint.
  static void setShader(Paint paint) {
    if (_$fragmentProgram case final ui.FragmentProgram program) {
      paint
        ..shader = program.fragmentShader()
        ..blendMode = BlendMode.src
        ..filterQuality = FilterQuality.low
        ..isAntiAlias = false;
    } else {
      _$loadfragmentProgramOnce.then((program) {
        if (program == null) return;
        paint
          ..shader = program.fragmentShader()
          ..blendMode = BlendMode.src
          ..filterQuality = FilterQuality.low
          ..isAntiAlias = false;
      }).ignore();
    }
  }
}
