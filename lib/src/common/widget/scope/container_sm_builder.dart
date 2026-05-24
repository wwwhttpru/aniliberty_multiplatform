import 'dart:async';

import 'package:aniliberty_multiplatform/src/common/widget/scope/container_scope_provider.dart';
import 'package:aniliberty_multiplatform/src/common/widget/scope/scope_progress_layout.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';

class ContainerSMBuilder<I, T extends Object, H extends ScopeStateHolder<T?>>
    extends StatefulWidget {
  final I id;
  final StateReadable<Map<I, H>> stateReadable;
  final Widget child;

  const ContainerSMBuilder({
    required this.id,
    required this.stateReadable,
    required this.child,
    super.key,
  });

  @override
  State<ContainerSMBuilder<I, T, H>> createState() =>
      _ContainerSMBuilderState<I, T, H>();
}

class _ContainerSMBuilderState<
  I,
  T extends Object,
  H extends ScopeStateHolder<T?>
>
    extends State<ContainerSMBuilder<I, T, H>> {
  late final ValueNotifier<H?> _holderNotifier;
  StreamSubscription<Map<I, H>>? _onStateSub;

  @override
  void initState() {
    super.initState();
    final state = widget.stateReadable.state[widget.id];
    _holderNotifier = ValueNotifier(state);

    if (state == null) {
      _onStateSub = widget.stateReadable.stream.listen(_onState);
    }
  }

  @override
  void dispose() {
    _onStateSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _holderNotifier,
    builder: (context, value, child) => switch (value) {
      H() => ContainerScopeProvider<T>(holder: value, child: child!),
      null => const ScopeProgressLayout(),
    },
    child: widget.child,
  );

  void _onState(Map<I, H> state) {
    final holder = state[widget.id];

    if (_holderNotifier.value == null && holder != null) {
      _holderNotifier.value = holder;
      _onStateSub?.cancel();
      _onStateSub = null;
    }
  }
}
