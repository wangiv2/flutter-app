import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
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
        _buildLanguageItem("中文简体", "zh"),
        _buildLanguageItem("English", "en"),
        _buildLanguageItem(flutterI18nUtil.translate("languageListPage.auto"), null),
      ],
    );
  }

  Widget _buildLanguageItem(String lan, value) {
    Color color = Theme.of(context).primaryColor;
    String currentLocale = flutterI18nUtil.currentLocale.languageCode;
    return ListTile(
      title: Text(
        lan,
        style: TextStyle(color: currentLocale == value ? color : null),
      ),
      trailing: currentLocale == value ? Icon(Icons.done, color: color) : null,
      onTap: () async {
        Locale locale;
        if (value != null) {
          locale = new Locale(value);
        } else {
          locale = Localizations.localeOf(context);
        }
        flutterI18nUtil.refresh(locale: locale);
        setState(() {}); // need to setState after refresh the language
        UserPreferenceEntity userPref = await sharePreferencesUtil.getUserPreference();
        if (userPref == null) {
          userPref = new UserPreferenceEntity();
        }
        log("set language to ${userPref.language}");
        userPref.language = value;
        sharePreferencesUtil.setUserPreference(userPref);
        showToast(flutterI18nUtil.translate("languageListPage.changed"));
      },
    );
  }
}
