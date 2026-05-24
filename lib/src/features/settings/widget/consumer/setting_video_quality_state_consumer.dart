import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_value_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/scope/settings_scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class SettingVideoQualityStateConsumer extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<VideoQuality>> builder;
  final StateBuilderCondition<SettingValueState<VideoQuality>>? buildWhen;
  final StateWidgetListener<SettingValueState<VideoQuality>> listener;
  final StateListenerCondition<SettingValueState<VideoQuality>>? listenWhen;
  final Widget? child;

  const SettingVideoQualityStateConsumer({
    required this.builder,
    required this.listener,
    this.buildWhen,
    this.listenWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateConsumer<VideoQuality>(
    stateReadable: SettingsScope.videoQualitySMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class SettingVideoQualityStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<VideoQuality>> builder;
  final StateBuilderCondition<SettingValueState<VideoQuality>>? buildWhen;
  final Widget? child;

  const SettingVideoQualityStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateBuilder<VideoQuality>(
    stateReadable: SettingsScope.videoQualitySMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class SettingVideoQualityStateListener extends StatelessWidget {
  final StateWidgetListener<SettingValueState<VideoQuality>> listener;
  final StateListenerCondition<SettingValueState<VideoQuality>>? listenWhen;
  final Widget child;

  const SettingVideoQualityStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateListener<VideoQuality>(
    stateReadable: SettingsScope.videoQualitySMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class SettingVideoQualityStateSelector<R> extends StatelessWidget {
  final StateWidgetSelector<SettingValueState<VideoQuality>, R> selector;
  final StateWidgetBuilder<R> builder;
  final Widget? child;

  const SettingVideoQualityStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      SettingValueStateSelector<VideoQuality, R>(
        stateReadable: SettingsScope.videoQualitySMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
