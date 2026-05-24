import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/component/section_widget.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileScope(
    unauthenticated: (_) => const SizedBox.shrink(),
    authenticated: (context) => const SectionWidget(
      title: 'Аккаунт',
      children: [_LogOutTile()],
    ),
  );
}

class _LogOutTile extends StatelessWidget {
  const _LogOutTile();

  @override
  Widget build(BuildContext context) => LogOutStateBuilder(
    builder: (context, state, child) => ListTile(
      iconColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.error,
      leading: const Icon(Icons.logout_rounded),
      title: const Text('Выход'),
      trailing: const Icon(Icons.chevron_right),
      enabled: state.isIdle,
      onTap: () => _onTapLogOut(context),
    ),
  );

  void _onTapLogOut(BuildContext context) {
    final wm = ProfileScope.profileWMOf(
      context,
      listen: false,
    );
    return wm.logOut();
  }
}
