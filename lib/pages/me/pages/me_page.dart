import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/funs.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/pages/me/router.dart';
import 'package:flutter_app/provider/theme_provider.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_app/res/gaps.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_app/widgets/login_page/router.dart';
import 'package:flutter_app/widgets/ui_widgets/click_item_widget.dart';
import 'package:provider/provider.dart';

class MePage extends NavigationBarPageWidget {
  @override
  String getPageName() => "MePage";

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() =>
      _MePageState();
}

class _MePageState extends NavigationBarPageWidgetState<MePage> {
  @override
  String getTitle() {
    return flutterI18nUtil.translate("homePage.tabTitles.me");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    String currentLocale = Global.profile.locale;
    bool isDarkMode =
        Global.profile.theme == ThemeProvider.themes[ThemeMode.dark];
    return ListView(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Gaps.hGap8,
              Icon(Icons.contact_mail, size: 54.0, color: !Funs.isDarkTheme() ? AppColors.app_main : null),
              Gaps.hGap8,
              Expanded(
                child: MergeSemantics(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(Global.profile.user.englishName, style: TextStyle(fontSize: 17.0),),
                      Text(Global.profile.user.email, style: TextStyle(color: Funs.isDarkTheme() ? AppColors.dark_text_gray : AppColors.text_gray),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(5),
        ),
        ClickItem(
            title: flutterI18nUtil.translate("languageListPage.title"),
            content:
                flutterI18nUtil.translate("languageListPage.$currentLocale"),
            onTap: () => RouterNavigator.push(context, MeRouter.languagePage)),
        ClickItem(
            title: flutterI18nUtil.translate("darkModeSelectPage.title"),
            content: flutterI18nUtil.translate(
                "darkModeSelectPage.${isDarkMode ? "enable" : "disable"}"),
            onTap: () => RouterNavigator.push(context, MeRouter.darkModePage)),
        ClickItem(
            title: flutterI18nUtil.translate("mePage.aboutUs"), onTap: () {}),
        ClickItem(
            title: flutterI18nUtil.translate("mePage.version"),
            content: "v1.0.0.200330",
            onTap: () {}),
        Container(
          margin: EdgeInsets.all(50.0),
          child: RaisedButton(
            child: Text(flutterI18nUtil.translate("mePage.logout")),
            onPressed: () {
              profileProvider(listen: false).user = null;
              RouterNavigator.push(context, LoginRouter.commonLogin,
                  replace: true,
                  clearStack: true,
                  transition: TransitionType.fadeIn);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(50.0),
          child: RaisedButton(
            child: Text('Disable Button'),
            onPressed: null,
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
