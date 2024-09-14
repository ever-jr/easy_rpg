import 'package:flutter/material.dart';

class SearchThings extends SearchDelegate {
  List<String> searchResults = [
    'This is a suggestion',
    'This is other suggestion',
    '...',
  ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
            return;
          }

          query = '';
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [];

    if (query.isNotEmpty) {
      suggestions = searchResults.where((searchResult) {
        final result = searchResult.toLowerCase();
        final input = query.toLowerCase();

        return result.contains(input);
      }).toList();
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
