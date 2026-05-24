import 'package:aniliberty_multiplatform/src/core/config/app_url_config.dart';
import 'package:meta/meta.dart';

abstract interface class AppConfig {
  abstract final AppUrlConfig urlConfig;
}

@immutable
final class AppConfigImpl implements AppConfig {
  @override
  final AppUrlConfig urlConfig;

  const AppConfigImpl({required this.urlConfig});
}
