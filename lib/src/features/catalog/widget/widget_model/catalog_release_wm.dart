import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ICatalogReleaseWM {
  /// Возвращает текст поиска
  String get search;

  /// Вызывается при начальной загрузки данных
  void onReadReleases();

  /// Вызывается при скроле списка для подзагрузки данных
  void onScrollList();

  /// Вызывается при нажатии на кнопку фильтра
  void onTapOpenFilter();

  /// Вызывается при вводе текста
  void onSearch(String value);

  /// Открывает страницу релиза
  void openRelease(String alias);
}

final class CatalogReleaseWM implements ICatalogReleaseWM {
  final ICatalogNavigationInteractor _catalogNavigationInteractor;
  final IReleasesNavigationInteractor _releasesNavigationInteractor;
  final CatalogReleaseSM _catalogReleaseSM;
  final CatalogFilterSM _catalogFilterSM;

  /// Текущий фильтр
  CatalogFilterEntity _filter;

  /// Search
  StreamController<String>? _searchQueryController;
  StreamSubscription<String>? _searchQuerySubscription;

  /// Подписка на изменение фильтра
  StreamSubscription<CatalogFilterState>? _catalogFilterSub;

  @override
  String get search => _catalogFilterSM.state.filter.search ?? '';

  CatalogReleaseWM({
    required this._catalogNavigationInteractor,
    required this._releasesNavigationInteractor,
    required this._catalogReleaseSM,
    required CatalogFilterSM catalogFilterSM,
  }) : _catalogFilterSM = catalogFilterSM,
       _filter = catalogFilterSM.state.filter;

  /// Initializes the interactor.
  @mustCallSuper
  Future<void> initialize() {
    assert(
      _catalogFilterSub == null,
      'Catalog filter subscription must be null',
    );

    _searchQueryController = StreamController<String>.broadcast();
    _searchQuerySubscription = _searchQueryController?.stream
        .debounceTime(const Duration(milliseconds: 300))
        .listen(_onSearch);

    _catalogFilterSub ??= _catalogFilterSM.stream.listen(_onCatalogFilter);
    return Future<void>.value();
  }

  /// Closes the interactor.
  @mustCallSuper
  Future<void> close() async {
    assert(
      _catalogFilterSub != null,
      'Catalog filter subscription must not be null',
    );

    await _catalogFilterSub?.cancel();
    _catalogFilterSub = null;

    await _searchQuerySubscription?.cancel();
    _searchQuerySubscription = null;

    await _searchQueryController?.close();
    _searchQueryController = null;
  }

  @override
  void onReadReleases() {
    final state = _catalogReleaseSM.state;
    if (state.isProgress) {
      return;
    }

    _catalogReleaseSM.onPagination(_filter);
  }

  @override
  void onScrollList() {
    if (!_catalogReleaseSM.state.isIdle) {
      return;
    }

    _catalogReleaseSM.onPagination(_filter);
  }

  @override
  void onTapOpenFilter() => _catalogNavigationInteractor.openFilter();

  @override
  void onSearch(String value) {
    final newSearch = value.trim();
    if (search == newSearch) {
      return;
    }

    _searchQueryController?.add(newSearch);
  }

  void _onCatalogFilter(CatalogFilterState state) {
    if (!state.isSubmitted || _filter == state.filter) {
      return;
    }

    // Обновляем фильтр
    _filter = state.filter;
    _catalogReleaseSM.onRefresh(_filter);
  }

  void _onSearch(String value) {
    _catalogFilterSM
      ..searchUpdate(value)
      ..submit();
  }

  @override
  void openRelease(String alias) =>
      _releasesNavigationInteractor.openRelease(alias);
}
