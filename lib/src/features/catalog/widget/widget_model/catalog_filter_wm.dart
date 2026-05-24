import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';

abstract interface class ICatalogFilterWM {
  /// Загружает информацию для фильтра
  void readReferences();

  /// Выбор фильтра "Жанры"
  void selectGenre(ReferencesGenreModel value);

  /// Выбор фильтра "Тип"
  void selectType(ReferencesTypeModel value);

  /// Выбор фильтра "Статус выхода"
  void selectPublishStatus(ReferencesPublishStatusModel value);

  /// Выбор фильтра "Сортировка"
  void selectSorting(ReferencesSortingValueModel? value);

  /// Выбор фильтра "Статус озвучки"
  void selectProductionStatus(ReferencesProductionStatusModel value);

  /// Выбор фильтра "Сезоны"
  void selectSeasons(ReferencesSeasonModel value);

  /// Выбор фильтра "Период выхода"
  void selectYear(int from, int to);

  /// Выбор фильтра "Возрастной рейтинг"
  void selectAgeRating(ReferencesAgeRatingModel value);

  /// Применить фильтр
  void apply();

  /// Сбросить фильтр
  void reset();
}

class CatalogFilterWM implements ICatalogFilterWM {
  final CatalogReferencesSM _catalogReferencesSM;
  final CatalogFilterSM _catalogFilterSM;
  final ICatalogNavigationInteractor _catalogNavigationInteractor;

  CatalogFilterWM({
    required this._catalogReferencesSM,
    required this._catalogFilterSM,
    required this._catalogNavigationInteractor,
  });

  @override
  void readReferences() {
    final state = _catalogReferencesSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _catalogReferencesSM.read();
  }

  @override
  void selectGenre(ReferencesGenreModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.genreUpdate(value);
  }

  @override
  void selectType(ReferencesTypeModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.typeUpdate(value);
  }

  @override
  void selectPublishStatus(ReferencesPublishStatusModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.publishStatusUpdate(value);
  }

  @override
  void selectSorting(ReferencesSortingValueModel? value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.sortingUpdate(value);
  }

  @override
  void selectProductionStatus(ReferencesProductionStatusModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.productionStatusUpdate(value);
  }

  @override
  void selectSeasons(ReferencesSeasonModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.seasonsUpdate(value);
  }

  @override
  void selectYear(int from, int to) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.yearUpdate(from, to);
  }

  @override
  void selectAgeRating(ReferencesAgeRatingModel value) {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.ageRatingUpdate(value);
  }

  @override
  void apply() {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.submit();
    _catalogNavigationInteractor.closeFilter();
  }

  @override
  void reset() {
    if (_catalogFilterSM.state.isProgress) {
      return;
    }

    _catalogFilterSM.reset();
    _catalogNavigationInteractor.closeFilter();
  }
}
