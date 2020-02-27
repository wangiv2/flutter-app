import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ChatPage extends NavigationBarPageWidget {
  @override
  String getPageName() => "ChatPage";

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() => _ChatPageState();

}

class _ChatPageState extends NavigationBarPageWidgetState<ChatPage> {
  @override
  String getTitle() {
    return FlutterI18n.translate(context, "homePage.tabTitles.chat");
  }

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await Future.delayed(Duration(seconds: 2)).then((_){
      log("delayed done");
      hideLoadingWidget();
      showNoDataWidget();
    });
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
