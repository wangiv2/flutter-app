import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/me/router.dart';
import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';
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

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await _getData();
    setState(() {});
    hideLoadingWidget();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    OpportunityEntity opportunity = widget.opportunity;
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(opportunity.title, style: TextStyle(fontWeight: FontWeight.w500),),
                Text(opportunity.subTitle),
                Text(opportunity.content),
                Text(opportunity.dateTime),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Center(
            child: RaisedButton(
              child: Text('Approve'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                widget.opportunity.isApproved = true;
                RouterNavigator.goBackWithParams(context, widget.opportunity);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  String getTitle() {
    return widget.opportunity.title.toString();
  }

  Future _getData() {
    return Future.delayed(Duration(seconds: 1));
  }

}
