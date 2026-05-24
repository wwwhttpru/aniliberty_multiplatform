import 'package:aniliberty_multiplatform/src/common/widget/scope/scope_progress_layout.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope/yx_scope.dart';

// ignore: implementation_imports
import 'package:yx_scope_flutter/src/core/provider.dart';

class ContainerScopeProvider<T> extends StatefulWidget {
  final ScopeStateHolder<T?> holder;
  final Widget child;

  const ContainerScopeProvider({
    required this.holder,
    required this.child,
    super.key,
  });

  @override
  State<ContainerScopeProvider<T>> createState() =>
      _ContainerScopeProviderState<T>();
}

class _ContainerScopeProviderState<T> extends State<ContainerScopeProvider<T>> {
  late final ValueNotifier<T?> _scope;
  late final ScopeStateHolder<T?> _holder;
  RemoveStateListener? _removeListener;

  @override
  void initState() {
    super.initState();
    _holder = widget.holder;
    _scope = ValueNotifier(_holder.scope);

    if (_scope.value == null) {
      _removeListener = _holder.listen(_onListener);
    }
  }

  @override
  void dispose() {
    _removeListener?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _scope,
    builder: (context, value, child) => switch (value) {
      T() => Provider<T?>(data: value, child: child ?? widget.child),
      null => const ScopeProgressLayout(),
    },
    child: widget.child,
  );

  void _onListener(T? scope) {
    if (!mounted) {
      return;
    }

    if (_scope.value == null && scope != null) {
      _scope.value = scope;
      _removeListener?.call();
      _removeListener = null;
    }
  }
}
