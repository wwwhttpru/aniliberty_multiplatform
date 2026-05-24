import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_value_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/scope/settings_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class SettingThemeStateConsumer extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<AppThemeMode>> builder;
  final StateBuilderCondition<SettingValueState<AppThemeMode>>? buildWhen;
  final StateWidgetListener<SettingValueState<AppThemeMode>> listener;
  final StateListenerCondition<SettingValueState<AppThemeMode>>? listenWhen;
  final Widget? child;

  const SettingThemeStateConsumer({
    required this.builder,
    required this.listener,
    this.buildWhen,
    this.listenWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateConsumer<AppThemeMode>(
    stateReadable: SettingsScope.themeModeSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class SettingThemeStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<AppThemeMode>> builder;
  final StateBuilderCondition<SettingValueState<AppThemeMode>>? buildWhen;
  final Widget? child;

  const SettingThemeStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateBuilder<AppThemeMode>(
    stateReadable: SettingsScope.themeModeSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class SettingThemeStateListener extends StatelessWidget {
  final StateWidgetListener<SettingValueState<AppThemeMode>> listener;
  final StateListenerCondition<SettingValueState<AppThemeMode>>? listenWhen;
  final Widget child;

  const SettingThemeStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateListener<AppThemeMode>(
    stateReadable: SettingsScope.themeModeSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class SettingThemeStateSelector<R> extends StatelessWidget {
  final StateWidgetSelector<SettingValueState<AppThemeMode>, R> selector;
  final StateWidgetBuilder<R> builder;
  final Widget? child;

  const SettingThemeStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      SettingValueStateSelector<AppThemeMode, R>(
        stateReadable: SettingsScope.themeModeSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
