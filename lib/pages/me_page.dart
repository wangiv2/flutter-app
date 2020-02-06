import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_page_widget.dart';
import 'package:flutter_app/pages/me/language_list_page.dart';
import 'package:flutter_app/router.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class MePage extends BasePageWidget {
  @override
  String getPageName() => "MePage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _MePageState();

}

class _MePageState extends BasePageWidgetState<MePage> {
  @override
  String getTitle() {
    return i18nTranslate("homePage.tabTitles.me");
  }

  @override
  Widget buildWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildListItem(i18nTranslate("mePage.language"), () {
          Router.pushPage(context, LanguageListPage());
        }),
        Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                child: Text(i18nTranslate("mePage.logout")),
                minWidth: getScreenWidth() - 100,
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
