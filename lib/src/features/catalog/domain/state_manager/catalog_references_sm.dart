import 'package:aniliberty_multiplatform/src/features/catalog/domain/repository/catalog_repository.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/state/catalog_references_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template catalog_references_sm}
/// State manager for catalog references feature.
///
/// Manages the catalog references state and handles references loading operations.
/// {@endtemplate}
class CatalogReferencesSM extends StateManager<CatalogReferencesState> {
  /// {@macro i_catalog_repository}
  final ICatalogRepository _repository;

  /// {@macro catalog_references_sm}
  ///
  /// Creates a new instance of [CatalogReferencesSM].
  ///
  /// [_repository] - The repository for catalog operations
  CatalogReferencesSM({required this._repository})
    : super(const CatalogReferencesState.idle());

  /// Reads catalog references from network.
  ///
  /// Loads all available filter options (genres, types, statuses, seasons,
  /// sorting options, years, and age ratings) and updates state accordingly:
  /// - Sets state to [CatalogReferencesState.progress] while loading
  /// - Sets state to [CatalogReferencesState.success] with results on success
  /// - Sets state to [CatalogReferencesState.error] on failure
  void read() => handle(
    (emit) async {
      emit(const CatalogReferencesState.progress());
      try {
        final references = await _repository.readReferencesFromNetwork();
        emit(CatalogReferencesState.success(references: references));
      } on Object catch (error, sk) {
        emit(const CatalogReferencesState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );
}
