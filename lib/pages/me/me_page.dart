import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_app/widgets/language_list_page/language_list_page.dart';
import 'package:flutter_app/routers/router.dart';

class MePage extends NavigatorPageWidget {
  @override
  String getPageName() => "MePage";

  @override
  NavigatorPageWidgetState<NavigatorPageWidget> getState() => _MePageState();

}

class _MePageState extends NavigatorPageWidgetState<MePage> {
  @override
  String getTitle() {
    return flutterI18nUtil.translate("homePage.tabTitles.me");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildListItem(flutterI18nUtil.translate("mePage.language"), () {
          Router.pushPage(context, LanguageListPage());
        }),
        Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                child: Text(flutterI18nUtil.translate("mePage.logout")),
                minWidth: screenUtil.screenWidth - 100,
                textColor: Colors.white,
                color: Colors.deepPurple,
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListItem(String title, VoidCallback action) {
    return ListTile(
      title: Text(
        title,
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.black26),
      onTap: action,
    );
  }
}