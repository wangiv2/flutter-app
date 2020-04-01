import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/provider/theme_provider.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';

class DarkModeSelectPage extends NavigationBarPageWidget {
  @override
  String getPageName() {
    return "DarkModeSelectPage";
  }

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() {
    return _DarkModeSelectPageState();
  }
}

class _DarkModeSelectPageState extends NavigationBarPageWidgetState<DarkModeSelectPage> {
  @override
  String getTitle() {
    return flutterI18nUtil.translate("darkModeSelectPage.title");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildItem(flutterI18nUtil.translate("darkModeSelectPage.enable"), ThemeMode.dark),
        _buildItem(flutterI18nUtil.translate("darkModeSelectPage.disable"), ThemeMode.light),
      ],
    );
  }

  Widget _buildItem(String lan, value) {
    Color color = Theme.of(context).primaryColor;
    bool isSelected = Global.profile.theme == ThemeProvider.themes[value];
    return ListTile(
      title: Text(
        lan,
        style: TextStyle(color: isSelected ? color : null),
      ),
      trailing: isSelected ? Icon(Icons.done, color: color) : null,
      onTap: () async {
        themeProvider(listen: false).setTheme(value);
      },
    );
  }
}
