import 'dart:async';

import 'package:flutter/foundation.dart'
    show ChangeNotifier, Listenable, ValueListenable, VoidCallback;

/// Function to get the changed value everytime
typedef ChangeFunction<S> = S Function();

extension ToStream on Listenable {
  Stream<S> toStream<S>(ChangeFunction<S> onChange) {
    final controller = StreamController<S>();

    void listener() => controller.add(onChange());
    addListener(listener);

    controller.onCancel = () {
      removeListener(listener);
      controller.close();
    };

    return controller.stream;
  }
}

/// Selector from [Listenable]
typedef ListenableSelector<Controller extends Listenable, Value> =
    Value Function(Controller controller);

/// Filter for [Listenable]
typedef ListenableFilter<Value> = bool Function(Value prev, Value next);

extension ListenableSelectorExtension<Controller extends Listenable>
    on Controller {
  /// Transform [Listenable] in to [ValueListenable]
  ValueListenable<Value> select<Value>(
    ListenableSelector<Controller, Value> selector, [
    ListenableFilter<Value>? test,
  ]) => _ValueListenableView<Controller, Value>(this, selector, test);
}

class _ValueListenableView<Controller extends Listenable, Value>
    with ChangeNotifier
    implements ValueListenable<Value> {
  _ValueListenableView(
    Controller controller,
    ListenableSelector<Controller, Value> selector,
    ListenableFilter<Value>? test,
  ) : _controller = controller,
      _selector = selector,
      _test = test;

  final Controller _controller;
  final ListenableSelector<Controller, Value> _selector;
  final ListenableFilter<Value>? _test;

  @override
  Value get value => hasListeners ? _$value : _selector(_controller);

  late Value _$value;

  void _update() {
    final newValue = _selector(_controller);
    if (identical(_$value, newValue)) return;
    if (!(_test?.call(_$value, newValue) ?? true)) return;
    _$value = newValue;
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    if (!hasListeners) {
      _$value = _selector(_controller);
      _controller.addListener(_update);
    }
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) _controller.removeListener(_update);
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    super.dispose();
  }
}
