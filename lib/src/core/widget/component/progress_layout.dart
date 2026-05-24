import 'package:flutter/material.dart';

class ProgressLayout extends StatelessWidget {
  const ProgressLayout() : super(key: const ValueKey('ProgressLayout'));

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
