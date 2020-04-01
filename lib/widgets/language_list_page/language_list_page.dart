import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:oktoast/oktoast.dart';

class LanguageListPage extends NavigationBarPageWidget {
  @override
  String getPageName() {
    return "LanguageListPage";
  }

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() {
    return _LanguageListPageState();
  }
}

class _LanguageListPageState extends NavigationBarPageWidgetState<LanguageListPage> {
  @override
  String getTitle() {
    return flutterI18nUtil.translate("languageListPage.title");
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildLanguageItem(flutterI18nUtil.translate("languageListPage.zh"), "zh"),
        _buildLanguageItem(flutterI18nUtil.translate("languageListPage.en"), "en"),
        _buildLanguageItem(flutterI18nUtil.translate("languageListPage.auto"), null),
      ],
    );
  }

  Widget _buildLanguageItem(String lan, value) {
    Color color = Theme.of(context).primaryColor;
    bool isSelected = flutterI18nUtil.currentLocale.languageCode == value;
    return ListTile(
      title: Text(
        lan,
        style: TextStyle(color: isSelected ? color : null),
      ),
      trailing: isSelected ? Icon(Icons.done, color: color) : null,
      onTap: () async {
        Locale locale;
        if (value != null) {
          locale = new Locale(value);
        } else {
          locale = Localizations.localeOf(context);
        }
        flutterI18nUtil.refresh(locale: locale);
        setState(() {}); // need to setState after refresh the language
        profileProvider(listen: false).locale = value;
        consoleLog("set language to $locale");
        Future.delayed(Duration(milliseconds: 200)).then((_) {
          showToast(flutterI18nUtil.translate("languageListPage.changed"));
        });
      },
    );
  }
}
