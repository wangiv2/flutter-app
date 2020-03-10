import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/me/router.dart';
import 'package:flutter_app/pages/opportunity/model/opportunity_entity.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';

class OpportunityDetailPage extends NavigationBarPageWidget {

  final OpportunityEntity opportunity;

  OpportunityDetailPage({Key key, @required this.opportunity}) : super(key: key);

  @override
  String getPageName() => "OpportunityDetailPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _OpportunityDetailPageState();

}

class _OpportunityDetailPageState extends NavigationBarPageWidgetState<OpportunityDetailPage> {

  String _content = "";

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await _getData();
    _content = "Detail page: ${widget.opportunity.content}";
    setState(() {});
    hideLoadingWidget();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(_content),
          MaterialButton(
            child: Text("Back"),
            onPressed: () {
              RouterNavigator.goBackWithParams(context, widget.opportunity);
            },
          ),
          MaterialButton(
            child: Text("Go"),
            onPressed: () {
              RouterNavigator.push(context, MeRouter.languagePage);
            },
          )
        ],
      ),
    );
  }

  @override
  String getTitle() {
    return widget.opportunity.id.toString();
  }

  Future _getData() {
    return Future.delayed(Duration(seconds: 1));
  }

}
