import 'package:aniliberty_multiplatform/src/common/common.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/scope/scope.dart';
import 'package:flutter/widgets.dart';

class FranchiseContainerStateBuilder extends StatelessWidget {
  final String franchiseId;
  final Widget child;

  const FranchiseContainerStateBuilder({
    required this.franchiseId,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      ContainerSMBuilder<
        String,
        FranchiseContainerOutputScope,
        FranchiseContainerHolder
      >(
        id: franchiseId,
        stateReadable: FranchisesScope.franchiseContainerSMOf(context),
        child: child,
      );
}
