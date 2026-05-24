import 'dart:async';
import 'dart:collection';

import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_navigation/yx_navigation.dart' as navigation;
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';

typedef FranchiseContainerState = Map<String, FranchiseContainerHolder>;

// TODO(wwwhttpru): Сделать базовую реализацию / общую с ReleaseContainerSM
class FranchiseContainerSM extends StateManager<FranchiseContainerState>
    implements AsyncLifecycle {
  final FranchisesContainerOutputScope _parent;
  final navigation.RouteNodeReadable _nodeReadable;
  final FranchisesRoute _route;

  /// Подписка на состояния дерева навигации
  StreamSubscription<void>? _onRouteNodeSub;

  FranchiseContainerSM({
    required this._route,
    required this._parent,
    required this._nodeReadable,
  }) : super(const {});

  @override
  Future<void> init() {
    _onRouteNodeSub ??= _nodeReadable.stream
        .startWith(_nodeReadable.state)
        .distinct()
        .listen(_onRouteNode);

    return Future<void>.value();
  }

  @override
  Future<void> dispose() async {
    await _onRouteNodeSub?.cancel();
    _onRouteNodeSub = null;
  }

  /// Собирает все маршруты открытые для релиза
  ///
  ///  - Если маршрут существует, то создает скоуп холдер
  ///  - Если маршрута нету, то удаляет скоуп холдер
  void _onRouteNode(navigation.RouteNode? routeNode) {
    handle((emit) async {
      final nodes = <navigation.RouteNode>[];

      routeNode?.traverse(
        (node) {
          nodes.add(node);
          return false;
        },
        predicate: (node) => node.route == _route.franchise,
      );

      // Собираем список идентификаторов
      final aliasOrIds = nodes
          .map((value) {
            final key = _route.franchiseId;
            return value.arguments[key];
          })
          .nonNulls
          .toSet();

      // Текущий список идентификаторов
      final current = state.keys.toSet();

      // Собираем список для создания / или удаления
      final needToCreate = aliasOrIds.difference(current);
      final needToRemove = current.difference(aliasOrIds);

      final newState = Map<String, FranchiseContainerHolder>.from(state);

      // удаляем старые
      for (final key in needToRemove) {
        final holder = newState[key];

        if (holder == null) {
          assert(false, 'Holder must not be null');
          continue;
        }

        await holder.drop();
        newState.remove(key);
      }

      // создаем новые
      for (final key in needToCreate) {
        final holder = FranchiseContainerHolder();
        await holder.create(
          FranchiseContainerInputScope(
            repository: _parent.repository,
            franchiseId: key,
          ),
        );
        newState[key] = holder;
      }

      // Эмитем новое состояние
      emit(UnmodifiableMapView(newState));
    });
  }
}
