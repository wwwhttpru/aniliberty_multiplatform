import 'dart:collection';

import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/entity/catalog_filter_entity.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/state/catalog_filter_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template catalog_filter_sm}
/// State manager for catalog filter feature.
///
/// Manages the catalog filter state and handles filter parameter updates.
/// {@endtemplate}
class CatalogFilterSM extends StateManager<CatalogFilterState> {
  /// {@macro catalog_filter_sm}
  ///
  /// Creates a new instance of [CatalogFilterSM] with initial empty filter.
  CatalogFilterSM()
    : super(CatalogFilterState.idle(filter: CatalogFilterEntity.initial()));

  /// Updates the search text in the filter.
  ///
  /// [value] - The new search text
  void searchUpdate(String value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final newFilter = state.filter.copyWith(search: value.trim());
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'searchUpdate',
  );

  /// Updates the genre selection in the filter.
  ///
  /// Toggles the genre: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The genre to toggle
  void genreUpdate(ReferencesGenreModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.genres.addOrRemove(value.id, value);
      final newFilter = state.filter.copyWith(genres: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'genreUpdate',
  );

  /// Updates the type selection in the filter.
  ///
  /// Toggles the type: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The type to toggle
  void typeUpdate(ReferencesTypeModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.types.addOrRemove(value.value, value);
      final newFilter = state.filter.copyWith(types: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'typeUpdate',
  );

  /// Updates the publish status selection in the filter.
  ///
  /// Toggles the publish status: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The publish status to toggle
  void publishStatusUpdate(ReferencesPublishStatusModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.publishStatuses.addOrRemove(value.value, value);
      final newFilter = state.filter.copyWith(publishStatuses: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'publishStatusUpdate',
  );

  /// Updates the production status selection in the filter.
  ///
  /// Toggles the production status: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The production status to toggle
  void productionStatusUpdate(ReferencesProductionStatusModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.productionStatuses.addOrRemove(
        value.value,
        value,
      );
      final newFilter = state.filter.copyWith(productionStatuses: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'productionStatusUpdate',
  );

  /// Updates the season selection in the filter.
  ///
  /// Toggles the season: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The season to toggle
  void seasonsUpdate(ReferencesSeasonModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.seasons.addOrRemove(value.value, value);
      final newFilter = state.filter.copyWith(seasons: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'seasonsUpdate',
  );

  /// Updates the year range in the filter.
  ///
  /// Sets the year range from [from] to [to]. If [from] > [to], the update is ignored.
  ///
  /// [from] - The start year
  /// [to] - The end year
  void yearUpdate(int from, int to) => handle(
    (emit) async {
      if (from > to || to < from) {
        return;
      }

      emit(CatalogFilterState.progress(filter: state.filter));
      final year = ReferencesYearsValue(fromYear: from, toYear: to);
      final newFilter = state.filter.copyWith(year: year);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'yearUpdate',
  );

  /// Updates the age rating selection in the filter.
  ///
  /// Toggles the age rating: adds it if not selected, removes it if already selected.
  ///
  /// [value] - The age rating to toggle
  void ageRatingUpdate(ReferencesAgeRatingModel value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final map = state.filter.ageRatings.addOrRemove(value.value, value);
      final newFilter = state.filter.copyWith(ageRatings: map);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'ageRatingUpdate',
  );

  /// Updates the sorting option in the filter.
  ///
  /// [value] - The sorting option to set (null to clear)
  void sortingUpdate(ReferencesSortingValueModel? value) => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final newFilter = state.filter.copyWith(sorting: value);
      emit(CatalogFilterState.idle(filter: newFilter));
    },
    identifier: 'sortingUpdate',
  );

  /// Submits the current filter.
  ///
  /// Marks the filter as submitted, which triggers the catalog release list update.
  void submit() => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      emit(CatalogFilterState.submitted(filter: state.filter));
    },
    identifier: 'submit',
  );

  /// Resets the filter to initial empty state and submits it.
  ///
  /// Clears all filter parameters and marks the filter as submitted.
  void reset() => handle(
    (emit) async {
      emit(CatalogFilterState.progress(filter: state.filter));
      final newFilter = CatalogFilterEntity.initial();
      emit(CatalogFilterState.submitted(filter: newFilter));
    },
    identifier: 'reset',
  );
}

/// Extension on [Map] that provides toggle functionality for filter selections.
extension _Map<K, V> on Map<K, V> {
  /// Toggles a key-value pair in the map.
  ///
  /// If the key exists, removes it. If the key doesn't exist, adds it with the value.
  /// Returns a new unmodifiable map with the updated state.
  ///
  /// [key] - The key to toggle
  /// [value] - The value to add if the key doesn't exist
  ///
  /// Returns a new [UnmodifiableMapView] with the toggled key-value pair
  Map<K, V> addOrRemove(K key, V value) {
    final current = this;

    // Check if the element exists in the map
    final hasValue = current[key] != null;
    final map = Map<K, V>.from(current);

    if (hasValue) {
      map.remove(key);
    } else {
      map[key] = value;
    }

    return UnmodifiableMapView(map);
  }
}
