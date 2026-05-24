import 'package:aniliberty_multiplatform/src/runner/app_runner.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy(const BrowserPlatformLocation(), true));
  AppRunner().run();
}
