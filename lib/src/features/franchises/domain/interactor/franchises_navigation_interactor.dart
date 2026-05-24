import 'package:aniliberty_multiplatform/src/features/franchises/router/franchises_route.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

abstract interface class IFranchisesNavigationInteractor {
  /// Opens the list of all franchises.
  void openAllFranchises();

  /// Opens franchise detail for [franchiseId].
  void openFranchiseById(String franchiseId);
}

@immutable
class FranchisesNavigationInteractor
    implements IFranchisesNavigationInteractor {
  final NavigationController _navigationController;
  final FranchisesRoute _route;

  const FranchisesNavigationInteractor({
    required this._navigationController,
    required this._route,
  });

  @override
  void openAllFranchises() {
    final route = _route.franchises;

    final routeNode = _navigationController.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _navigationController.push(route);
  }

  @override
  void openFranchiseById(String franchiseId) {
    final route = _route.franchise;

    final routeNode = _navigationController.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _navigationController.push(
      route,
      arguments: {_route.franchiseId: franchiseId},
    );
  }
}
