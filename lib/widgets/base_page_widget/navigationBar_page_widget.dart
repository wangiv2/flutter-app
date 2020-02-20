import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

abstract class NavigatorPageWidget extends BasePageWidget{}

abstract class NavigatorPageWidgetState<T extends NavigatorPageWidget> extends BasePageWidgetState<T> {

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(getTitle()),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: Container(
//              color: Colors.white,
              child: Stack(
                children: <Widget>[buildContentWidget(context)],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget buildContentWidget(BuildContext context);
  String getTitle();
}
