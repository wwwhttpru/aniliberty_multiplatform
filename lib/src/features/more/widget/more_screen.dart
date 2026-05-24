import 'package:aniliberty_multiplatform/src/features/more/widget/component/about_section.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/component/account_section.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/component/profile_section.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/component/settings_section.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Ещё')),
    body: const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: ProfileSection()),
        SliverToBoxAdapter(child: SettingsSection()),
        SliverToBoxAdapter(child: AboutSection()),
        SliverToBoxAdapter(child: AccountSection()),
      ],
    ),
  );
}
