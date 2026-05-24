import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/widget_model/promotions_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class PromotionsScope extends StatelessWidget {
  final Widget child;

  const PromotionsScope({
    required this.child,
    super.key,
  });

  static PromotionsContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<PromotionsContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'PromotionsContainerOutputScope',
    );
  }

  static PromotionsSM promotionsSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).promotionsSM;

  static IPromotionsWM promotionsWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).promotionsWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<PromotionsContainerOutputScope>(
        holder: AppScope.containerOf(context).promotionsContainerHolder,
        child: ScopeBuilder<PromotionsContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
