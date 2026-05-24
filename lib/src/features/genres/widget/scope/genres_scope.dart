import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/genres/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class GenresScope extends StatelessWidget {
  final Widget child;

  const GenresScope({required this.child, super.key});

  static GenresContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<GenresContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(container, 'GenresContainerOutputScope');
  }

  static IGenresNavigationInteractor navigationInteractorOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).navigationInteractor;

  static GenresSM genresSMOf(BuildContext context, {bool listen = true}) =>
      containerOf(context, listen: listen).genresSM;

  static GenresSM genresRandomSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).genresRandomSM;

  static IGenresWM genresWMOf(BuildContext context, {bool listen = true}) =>
      containerOf(context, listen: listen).genresWM;

  static IGenresRandomWM genresRandomWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).genresRandomWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<GenresContainerOutputScope>(
        holder: AppScope.containerOf(context).genresContainerHolder,
        child: ScopeBuilder<GenresContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
