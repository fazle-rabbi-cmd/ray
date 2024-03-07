// search_widget.dart
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchWidget({
    required this.controller,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search for a location...',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearch(controller.text);
          },
        ),
      ),
    );
  }
}
