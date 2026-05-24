import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template app_route}
/// Route for app
/// {@endtemplate}
@immutable
class AppRoute {
  /// Root route
  YxRoute get root => const YxRoute(id: 'root');

  /// Tab bar route
  YxRoute get tabBar => const YxRoute(id: 'tab-bar');

  /// Feed tab route
  YxRoute get feedTab => const YxRoute(id: 'feed-tab');

  /// Catalog tab route
  YxRoute get catalogTab => const YxRoute(id: 'catalog-tab');

  /// More tab route
  YxRoute get moreTab => const YxRoute(id: 'more-tab');

  /// All tabs
  Set<YxRoute> get allTabs => {moreTab, catalogTab, feedTab};

  /// {@macro app_route}
  const AppRoute();
}
