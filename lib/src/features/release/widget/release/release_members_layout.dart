import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:flutter/material.dart';

class ReleaseMembersLayout extends StatelessWidget {
  final AnimeReleaseModel releaseModel;

  const ReleaseMembersLayout({required this.releaseModel, super.key});

  @override
  Widget build(BuildContext context) {
    final members = releaseModel.members;

    if (members == null || members.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyLayout(),
      );
    }

    return SliverList.separated(
      itemCount: members.length,
      itemBuilder: (context, index) => _MemberListItem(
        key: ValueKey(members[index].id),
        releaseMember: members[index],
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _MemberListItem extends StatelessWidget {
  final AnimeReleaseMemberModel releaseMember;

  const _MemberListItem({required this.releaseMember, super.key});

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: _Poster(releaseMember.user?.avatar),
    title: Text(releaseMember.nickname),
    subtitle: Text(releaseMember.role.description),
  );
}

class _Poster extends StatelessWidget {
  final PosterPreviewModel? preview;

  const _Poster(this.preview);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: SizedBox.square(
      dimension: 48,
      child: StorageNetworkImage(
        src: preview?.optimized.src,
        thumbnail: preview?.optimized.thumbnail,
      ),
    ),
  );
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => const ListTile(
    contentPadding: EdgeInsets.all(8),
    leading: Icon(Icons.people_outline, size: 48),
    title: Text('Нет участников'),
    subtitle: Text('У данного релиза нет информации по участникам'),
  );
}
