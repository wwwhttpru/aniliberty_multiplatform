import 'dart:async';
import 'dart:collection';

import 'package:aniliberty_multiplatform/src/features/release/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/release/router/router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_navigation/yx_navigation.dart' as navigation;
import 'package:yx_state/yx_state.dart';

typedef ReleaseContainerState = Map<String, ReleaseContainerHolder>;

class ReleaseContainerSM extends StateManager<ReleaseContainerState> {
  final ReleasesContainerOutputScope _parent;
  final navigation.RouteNodeReadable _nodeReadable;
  final ReleaseRoute _route;

  /// Подписка на состояния дерева навигации
  StreamSubscription<void>? _onRouteNodeSub;

  ReleaseContainerSM({
    required this._route,
    required this._parent,
    required this._nodeReadable,
  }) : super(const {});

  Future<void> init() {
    _onRouteNodeSub ??= _nodeReadable.stream
        .startWith(_nodeReadable.state)
        .distinct()
        .listen(_onRouteNode);

    return Future<void>.value();
  }

  @override
  Future<void> close() async {
    await _onRouteNodeSub?.cancel();
    _onRouteNodeSub = null;
    _clear();
    return super.close();
  }

  /// Собирает все маршруты открытые для релиза
  ///
  ///  - Если маршрут существует, то создает скоуп холдер
  ///  - Если маршрута нету, то удаляет скоуп холдер
  void _onRouteNode(navigation.RouteNode? routeNode) {
    handle((emit) async {
      final releaseNodes = <navigation.RouteNode>[];

      routeNode?.traverse(
        (node) {
          releaseNodes.add(node);
          return false;
        },
        predicate: (routeNode) => routeNode.route == _route.release,
      );

      // Собираем список идентификаторов
      final aliasOrIds = releaseNodes
          .map((value) {
            final key = _route.releaseAliasOrId;
            return value.arguments[key];
          })
          .nonNulls
          .toSet();

      // Текущий список идентификаторов
      final current = state.keys.toSet();

      // Собираем список для создания / или удаления
      final needToCreate = aliasOrIds.difference(current);
      final needToRemove = current.difference(aliasOrIds);

      final newState = Map<String, ReleaseContainerHolder>.from(state);

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
        final holder = ReleaseContainerHolder();
        await holder.create(
          ReleaseContainerInputScope(
            releaseRepository: _parent.releaseRepository,
            navigationInteractor: _parent.navigationInteractor,
            aliasOrId: key,
          ),
        );
        newState[key] = holder;
      }

      // Эмитем новое состояние
      emit(UnmodifiableMapView(newState));
    });
  }

  void _clear() => handle(
    (emit) async {
      for (final holder in state.values) {
        await holder.drop();
      }

      emit(const {});
    },
  );
}
