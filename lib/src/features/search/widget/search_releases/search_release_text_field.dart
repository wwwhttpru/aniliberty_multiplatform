import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/scope/search_scope.dart';
import 'package:flutter/material.dart';

class SearchReleaseTextField extends StatefulWidget {
  const SearchReleaseTextField({super.key});

  @override
  State<SearchReleaseTextField> createState() => _SearchReleaseTextFieldState();
}

class _SearchReleaseTextFieldState extends State<SearchReleaseTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final wm = SearchScope.animeSearchWMOf(
      context,
      listen: false,
    );

    final text = wm.query;
    _controller = TextEditingController(text: text)..addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    autofocus: true,
    decoration: InputDecoration(
      hint: const Text('Введите название аниме...'),
      prefixIcon: const Icon(Icons.search_outlined),
      border: context.resolver.inputBorder,
      suffixIcon: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, _) => switch (value.text.isEmpty) {
          true => const SizedBox.shrink(),
          false => _ClearButton(onPressed: _onClear),
        },
      ),
    ),
  );

  /// Clears the text field.
  void _onClear() => _controller.clear();

  /// Called when the text field is changed.
  void _onChanged() {
    final wm = SearchScope.animeSearchWMOf(
      context,
      listen: false,
    );

    final value = _controller.text;
    return wm.search(value);
  }
}

class _ClearButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ClearButton({required this.onPressed});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: const Icon(Icons.clear),
  );
}
