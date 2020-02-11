import 'package:flutter/material.dart';
import 'package:flutter_app/base/base_page_widget.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LanguageListPage extends BasePageWidget {
  @override
  String getPageName() {
    return "LanguageListPage";
  }

  @override
  BasePageWidgetState<BasePageWidget> getState() {
    return _LanguageListPageState();
  }
}

class _LanguageListPageState extends BasePageWidgetState<LanguageListPage> {
  @override
  String getTitle() {
    return FlutterI18n.translate(context, "languageListPage.title");
  }

  @override
  Widget buildWidget(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildLanguageItem("中文简体", "zh"),
        _buildLanguageItem("English", "en"),
        _buildLanguageItem(FlutterI18n.translate(context, "languageListPage.auto"), null),
      ],
    );
  }

  Widget _buildLanguageItem(String lan, value) {
    Color color = Theme.of(context).primaryColor;
    String currentLocale = FlutterI18n.currentLocale(context).languageCode;
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
        FlutterI18n.refresh(context, locale);
        setState(() {});
        UserPreferenceEntity userPref = await sharePreferencesUtil.getUserPreference();
        if (userPref == null) {
          userPref = new UserPreferenceEntity();
        }
        log("userPref.language: ${userPref.language}");
        userPref.language = value;
        sharePreferencesUtil.setUserPreference(userPref);
        log("userPref.language2: ${userPref.language}");
      },
    );
  }
}
