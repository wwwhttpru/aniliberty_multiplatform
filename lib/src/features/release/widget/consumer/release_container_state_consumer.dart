import 'package:aniliberty_multiplatform/src/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/release/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';

class ReleaseContainerStateBuilder extends StatelessWidget {
  final String aliasOrId;
  final Widget child;

  const ReleaseContainerStateBuilder({
    required this.aliasOrId,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      ContainerSMBuilder<
        String,
        ReleaseContainerOutputScope,
        ReleaseContainerHolder
      >(
        id: aliasOrId,
        stateReadable: ReleasesScope.releaseContainerSMOf(context),
        child: child,
      );
}
