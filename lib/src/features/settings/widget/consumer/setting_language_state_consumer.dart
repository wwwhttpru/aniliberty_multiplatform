import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/consumer/setting_value_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/scope/settings_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class SettingLanguageStateConsumer extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<AppLanguage>> builder;
  final StateBuilderCondition<SettingValueState<AppLanguage>>? buildWhen;
  final StateWidgetListener<SettingValueState<AppLanguage>> listener;
  final StateListenerCondition<SettingValueState<AppLanguage>>? listenWhen;
  final Widget? child;

  const SettingLanguageStateConsumer({
    required this.builder,
    required this.listener,
    this.buildWhen,
    this.listenWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateConsumer<AppLanguage>(
    stateReadable: SettingsScope.languageSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class SettingLanguageStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<SettingValueState<AppLanguage>> builder;
  final StateBuilderCondition<SettingValueState<AppLanguage>>? buildWhen;
  final Widget? child;

  const SettingLanguageStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateBuilder<AppLanguage>(
    stateReadable: SettingsScope.languageSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class SettingLanguageStateListener extends StatelessWidget {
  final StateWidgetListener<SettingValueState<AppLanguage>> listener;
  final StateListenerCondition<SettingValueState<AppLanguage>>? listenWhen;
  final Widget child;

  const SettingLanguageStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingValueStateListener<AppLanguage>(
    stateReadable: SettingsScope.languageSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class SettingLanguageStateSelector<R> extends StatelessWidget {
  final StateWidgetSelector<SettingValueState<AppLanguage>, R> selector;
  final StateWidgetBuilder<R> builder;
  final Widget? child;

  const SettingLanguageStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      SettingValueStateSelector<AppLanguage, R>(
        stateReadable: SettingsScope.languageSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
