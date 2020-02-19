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
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: screenUtil.screenWidth,
              height: screenUtil.screenHeight,
              color: Colors.white, // background color
              child: Stack(
                children: <Widget>[buildContentWidget(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContentWidget(BuildContext context);
  String getTitle();
}
