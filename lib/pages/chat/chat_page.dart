import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/navigator_page_widget.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ChatPage extends NavigatorPageWidget {
  @override
  String getPageName() => "ChatPage";

  @override
  NavigatorPageWidgetState<NavigatorPageWidget> getState() => _ChatPageState();

}

class _ChatPageState extends NavigatorPageWidgetState<ChatPage> {
  @override
  String getTitle() {
    return FlutterI18n.translate(context, "homePage.tabTitles.chat");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("I am Chat Index Page")
        ],
      ),
    );
  }
}
