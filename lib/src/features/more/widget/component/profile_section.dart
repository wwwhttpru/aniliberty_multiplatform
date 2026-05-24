import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/component/section_widget.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/scope/more_scope.dart';
import 'package:aniliberty_multiplatform/src/features/profile/profile.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileScope(
    unauthenticated: (_) => const _UnAuthenticatedLayout(),
    authenticated: (_) => const _AuthenticatedLayout(),
  );
}

class _UnAuthenticatedLayout extends StatelessWidget {
  const _UnAuthenticatedLayout();

  @override
  Widget build(BuildContext context) => SectionWidget(
    title: 'Профиль',
    children: [
      ListTile(
        leading: const Icon(Icons.person_outline),
        title: const Text('Войти в аккаунт'),
        subtitle: const Text('Войдите для доступа к профилю'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _onTap(context),
      ),
    ],
  );

  void _onTap(BuildContext context) {
    final wm = MoreScope.wmOf(
      context,
      listen: false,
    );
    return wm.openLogin();
  }
}

class _AuthenticatedLayout extends StatelessWidget {
  const _AuthenticatedLayout();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SectionWidget(title: 'Профиль', children: [_ProfileListTile()]),
      SectionWidget(
        title: 'Мое',
        children: [
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Избранное'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _onTapMyFavorites(context),
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark_outlined),
            title: const Text('Коллекция'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _onTapMyCollection(context),
          ),
        ],
      ),
    ],
  );

  void _onTapMyCollection(BuildContext context) {
    // TODO(wwwhttpru): Implement navigation to my collection screen
  }

  void _onTapMyFavorites(BuildContext context) {
    // TODO(wwwhttpru): Implement navigation to my favorites screen
  }
}

class _ProfileListTile extends StatelessWidget {
  const _ProfileListTile();

  @override
  Widget build(BuildContext context) => ProfileStateBuilder(
    builder: (context, state, child) => ListTile(
      leading: _ProfileAvatar(avatar: state.profileOrNull?.avatar),
      title: state.maybeMap(
        orElse: () => const Text('Загрузка...'),
        error: (_) => const Text('Произошло что-то не так'),
        success: (value) => Text(value.profile.nickname),
      ),
      subtitle: state.maybeMap(
        orElse: () => const Text('Ищем вас среди анимешников...'),
        error: (_) => const Text('Попробуйте еще раз'),
        success: (value) => Text('ID: ${value.profile.id}'),
      ),
      trailing: state.mapOrNull(
        error: (_) => const Icon(Icons.refresh),
        success: (_) => const Icon(Icons.chevron_right),
      ),
      onTap: state.mapOrNull<VoidCallback>(
        error: (_) =>
            () => _onReadProfile(context),
        success: (_) =>
            () => _onTap(context),
      ),
    ),
  );

  void _onReadProfile(BuildContext context) {
    final wm = ProfileScope.profileWMOf(
      context,
      listen: false,
    );
    return wm.read();
  }

  void _onTap(BuildContext context) {
    final wm = ProfileScope.profileWMOf(
      context,
      listen: false,
    );
    return wm.openProfile();
  }
}

class _ProfileAvatar extends StatelessWidget {
  final PosterPreviewModel? avatar;

  const _ProfileAvatar({required this.avatar});

  @override
  Widget build(BuildContext context) {
    final value = avatar;
    if (value == null) {
      return const Icon(Icons.person_outline);
    }
    return StorageNetworkImage(
      src: value.src,
      thumbnail: value.thumbnail,
    );
  }
}
