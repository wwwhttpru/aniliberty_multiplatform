import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/consumer/app_status_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/scope/app_status_scope.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/screen/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/widget_model/app_status_wm.dart';
import 'package:flutter/material.dart';

/// Screen for displaying app status information.
class AppStatusScreen extends StatefulWidget {
  const AppStatusScreen({super.key});

  @override
  State<AppStatusScreen> createState() => _AppStatusScreenState();
}

class _AppStatusScreenState extends State<AppStatusScreen> {
  late final IAppStatusWM _appStatusWM;

  @override
  void initState() {
    super.initState();
    _appStatusWM = AppStatusScope.appStatusWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _appStatusWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Статус API')),
    body: AppStatusStateBuilder(
      builder: (context, state, child) => AnimateSwitchLayout(
        child: state.maybeMap(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.appStatus),
          error: (_) => ErrorLayout(onTap: _appStatusWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AppStatusModel appStatus;

  const _SuccessLayout(
    this.appStatus,
  ) : super(key: const Key('_SuccessLayout'));

  @override
  Widget build(BuildContext context) {
    final hPadding = context.spacingHOrSa;
    final vPadding = context.spacingVOrSa;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: hPadding.copyWith(bottom: 8),
          sliver: SliverToBoxAdapter(
            child: ServiceStatusCard(isAlive: appStatus.isAlive),
          ),
        ),
        SliverPadding(
          padding: hPadding.copyWith(top: 8, bottom: 8),
          sliver: SliverToBoxAdapter(
            child: RequestInfoCard(request: appStatus.request),
          ),
        ),
        SliverPadding(
          padding: hPadding.copyWith(
            top: 8,
            bottom: vPadding.bottom,
          ),
          sliver: SliverToBoxAdapter(
            child: EndpointsCard(
              endpoints: appStatus.availableApiEndpoints,
            ),
          ),
        ),
      ],
    );
  }
}
