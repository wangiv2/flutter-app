import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/search_page_widget/search_page_delegate.dart';

class OpportunitySearchPage extends SearchPageDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('22222'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('111111'),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
//        primaryColor: Colors.deepPurple,
        primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
        primaryColorBrightness: Brightness.dark,
//        textTheme: theme.textTheme.copyWith(title: TextStyle(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.grey)));
  }

  @override
  String get searchFieldLabel => "Search";
}
