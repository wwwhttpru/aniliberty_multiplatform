import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/entity/tab_bar_state.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template tab_bar_route}
/// Route configuration for tab bar screens.
///
/// Provides route definitions and utilities for navigating to tab bar screens.
/// {@endtemplate}
@immutable
class TabBarRoute {
  /// Parent route
  final YxRoute parentRoute;

  /// Tab bar screen ID
  final YxRoute tab;

  /// Feed tab screen ID
  final YxRoute feedTab;

  /// Catalog tab screen ID
  final YxRoute catalogTab;

  /// More tab screen ID
  final YxRoute moreTab;

  /// All tabs
  Set<YxRoute> get allTabs => {moreTab, catalogTab, feedTab};

  /// Initial route
  YxRoute get initialRoute => feedTab;

  /// {@macro tab_bar_route}
  const TabBarRoute({
    required this.parentRoute,
    required this.tab,
    required this.feedTab,
    required this.catalogTab,
    required this.moreTab,
  });

  /// Get tab from route
  TabBarTab? fromRoute(YxRoute route) {
    if (route == feedTab) {
      return TabBarTab.feed;
    }
    if (route == catalogTab) {
      return TabBarTab.catalog;
    }
    if (route == moreTab) {
      return TabBarTab.more;
    }

    return null;
  }
}
