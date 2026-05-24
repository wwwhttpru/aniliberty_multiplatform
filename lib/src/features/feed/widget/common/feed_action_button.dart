import 'package:flutter/material.dart';

class FeedActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const FeedActionButton({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(onPressed: onTap, child: Text(text));
}
