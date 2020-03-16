import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/widgets/search_page_widget/search_page_delegate.dart';
import 'package:flutter_app/widgets/ui_widgets/loading_widget.dart';
import 'package:flutter_app/widgets/ui_widgets/noData_widget.dart';

class CommonSearchDelegate extends SearchPageDelegate<String>{

  List<String> suggestionItems = [];
  Future Function(String query) onSearch;
  Widget Function(BuildContext context, int index, Object item) buildResultItem;

  List<Object> _resultItems = [];

  CommonSearchDelegate({this.suggestionItems, @required this.onSearch, @required this.buildResultItem}) : super();

  @override
  String getPlaceHolderText(BuildContext context) {
    return FlutterI18nUtil(context).translate('common.searchPage.placeHolder');
  }

  @override
  void onSubmitted(BuildContext context) async {
    showLoading(context);
    _resultItems = await onSearch(query);
    showResults(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
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
  Widget buildLoading(BuildContext context) {
    return LoadingWidget();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_resultItems.length == 0) {
      return NoDataWidget();
    } else {
      return ListView.builder(
        itemCount: _resultItems.length,
        itemBuilder: (BuildContext context, int index) => buildResultItem(context, index, _resultItems[index]),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Widget content = Container();
    if (query.isEmpty) {
      content = Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                FlutterI18nUtil(context).translate('common.searchPage.history'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              child: Wrap(
                spacing: 10,
                children: suggestionItems.map((item) {
                  return buildSuggestItem(context, item);
                }).toList(),
              ),
            )
          ],
        ),
      );
    }
    return Container(
      alignment: Alignment.topLeft,
      child: content,
    );
  }

  Widget buildSuggestItem(BuildContext context, String text) {
    return Container(
      child: CupertinoButton(
        padding: EdgeInsets.all(0.0),
        onPressed: (){
          print(text);
          query = text;
          onSubmitted(context);
        },
        child: Chip(
          label: Text(text),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      )
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
        primaryColorBrightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
        textTheme: theme.primaryTextTheme.copyWith(title: theme.primaryTextTheme.title.copyWith(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white30),
        )
    );
  }
}
