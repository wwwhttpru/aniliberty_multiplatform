import 'package:aniliberty_multiplatform/src/features/catalog/domain/entity/catalog_filter_entity.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/repository/catalog_repository.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/state/catalog_release_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template catalog_release_sm}
/// State manager for catalog releases feature.
///
/// Manages the catalog releases state and handles releases loading operations with pagination.
/// {@endtemplate}
class CatalogReleaseSM extends StateManager<CatalogReleaseState> {
  /// {@macro i_catalog_repository}
  final ICatalogRepository _repository;

  /// {@macro catalog_release_sm}
  ///
  /// Creates a new instance of [CatalogReleaseSM].
  ///
  /// [_repository] - The repository for catalog operations
  CatalogReleaseSM({required this._repository})
    : super(const CatalogReleaseState.idle());

  /// Loads the next page of releases using pagination.
  ///
  /// Loads releases matching the specified filter and appends them to the existing list.
  /// Updates state accordingly:
  /// - Sets state to [CatalogReleaseState.progress] while loading
  /// - Sets state to [CatalogReleaseState.success] with results on success
  /// - Sets state to [CatalogReleaseState.error] on failure (if previous data exists)
  /// - Sets state to [CatalogReleaseState.fatalError] on failure (if no previous data)
  ///
  /// Does nothing if pagination has reached the end of pages.
  ///
  /// [filter] - The filter entity to apply to the query
  void onPagination(CatalogFilterEntity filter) {
    handle((emit) async {
      if (state.pagination.isEndOfPage) return;
      final currentPagination = state.pagination;
      final nextPage = currentPagination.nextPage;

      try {
        emit(
          CatalogReleaseState.progress(
            release: state.release,
            pagination: currentPagination.copyWith(currentPage: nextPage),
          ),
        );

        final result = await _repository.readReleasesFromNetwork(
          query: filter.toQuery(nextPage, 15),
        );

        emit(
          CatalogReleaseState.success(
            release: [...state.release, ...result.data],
            pagination: result.meta.pagination,
          ),
        );
      } on Object catch (error, sk) {
        if (state.release.isEmpty) {
          emit(
            CatalogReleaseState.fatalError(
              release: state.release,
              pagination: currentPagination,
            ),
          );
        } else {
          emit(
            CatalogReleaseState.error(
              release: state.release,
              pagination: currentPagination,
            ),
          );
        }

        addError(error, sk);
      } finally {
        if (!state.isFatal) {
          emit(
            CatalogReleaseState.idle(
              release: state.release,
              pagination: state.pagination,
            ),
          );
        }
      }
    });
  }

  /// Refreshes the releases list by resetting and loading the first page.
  ///
  /// Resets the state to initial and loads releases matching the specified filter
  /// starting from the first page.
  ///
  /// [filter] - The filter entity to apply to the query
  void onRefresh(CatalogFilterEntity filter) {
    handle((emit) async {
      emit(const CatalogReleaseState.idle());
    });

    onPagination(filter);
  }
}
