import 'dart:async';

import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/consumer/promotions_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/promotions/promotion_banner_item.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/scope/promotions_scope.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/widget_model/promotions_wm.dart';
import 'package:flutter/material.dart';

class PromotionsBannerLayout extends StatefulWidget {
  const PromotionsBannerLayout({super.key});

  @override
  State<PromotionsBannerLayout> createState() => _PromotionsBannerLayoutState();
}

class _PromotionsBannerLayoutState extends State<PromotionsBannerLayout> {
  late final IPromotionsWM _promotionsWM;

  @override
  void initState() {
    super.initState();
    _promotionsWM = PromotionsScope.promotionsWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _promotionsWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 320,
    child: PromotionsStateBuilder(
      builder: (context, state, _) => state.map(
        idle: (_) => const _ProgressLayout(),
        progress: (_) => const _ProgressLayout(),
        success: (value) => _SuccessLayout(value.mediaPromotions),
        error: (_) => ErrorLayout(onTap: _promotionsWM.read),
      ),
    ),
  );
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout();

  @override
  Widget build(BuildContext context) => const ProgressLayout();
}

class _SuccessLayout extends StatefulWidget {
  final MediaPromotionsModel mediaPromotions;

  const _SuccessLayout(this.mediaPromotions);

  @override
  State<_SuccessLayout> createState() => _SuccessLayoutState();
}

class _SuccessLayoutState extends State<_SuccessLayout> {
  late final PageController _controller;
  late Timer _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _onAutoScroll(),
    );
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      PageView.builder(
        controller: _controller,
        itemCount: widget.mediaPromotions.promotions.length,
        itemBuilder: (context, index) {
          final value = widget.mediaPromotions.promotions[index];
          return PromotionBannerItem(
            key: ValueKey(value.id),
            mediaPromotion: value,
          );
        },
      ),
      Positioned(
        bottom: 24,
        right: 24,
        child: _Buttons(onLeftTap: _onLeftTap, onRightTap: _onRightTap),
      ),
    ],
  );

  void _resetAutoScrollTimer() {
    _autoScrollTimer.cancel();
    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _onAutoScroll(),
    );
  }

  void _onAutoScroll() {
    if (!_controller.hasClients || !mounted) {
      return;
    }

    final length = widget.mediaPromotions.promotions.length;
    final currentIndex = _controller.page?.round() ?? 0;

    if (currentIndex == length - 1) {
      _controller.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    _controller.animateToPage(
      currentIndex + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onLeftTap() {
    if (!_controller.hasClients) {
      return;
    }

    _resetAutoScrollTimer();
    final length = widget.mediaPromotions.promotions.length;
    final currentIndex = _controller.page?.round() ?? 0;

    if (currentIndex == 0) {
      _controller.animateToPage(
        length - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    _controller.animateToPage(
      currentIndex - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onRightTap() {
    if (!_controller.hasClients) {
      return;
    }

    _resetAutoScrollTimer();
    final length = widget.mediaPromotions.promotions.length;
    final currentIndex = _controller.page?.round() ?? 0;

    if (currentIndex == length - 1) {
      _controller.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    _controller.animateToPage(
      currentIndex + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const _Buttons({required this.onLeftTap, required this.onRightTap});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _Button(icon: Icons.chevron_left, onTap: onLeftTap),
      const SizedBox(width: 4),
      _Button(icon: Icons.chevron_right, onTap: onRightTap),
    ],
  );
}

class _Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _Button({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => IconButton.filledTonal(
    style: IconButton.styleFrom(
      minimumSize: const Size.square(36),
      fixedSize: const Size.square(36),
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0x1affffff),
    ),
    icon: Icon(icon, size: 20),
    onPressed: onTap,
  );
}
