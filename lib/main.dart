import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/router.dart';
import 'package:flutter_app/utils/share_preferences_util.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'model/user_preference_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferenceEntity userPref = await SharePreferencesUtil().getUserPreference();
  print("main userPref.language: ${userPref.language}");
  runApp(new MyApp(userPref.language));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String _language = "en";
  MyApp(String language){
    _language = language;
  }

  @override
  Widget build(BuildContext context) {

//    print("userPref.language: ${userPref.language}");
//    FlutterI18n.refresh(context, new Locale(userPref.language));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      localizationsDelegates: [
        FlutterI18nDelegate(
            useCountryCode: false,
            fallbackFile: 'en',
            path: 'locales',
            forcedLocale: new Locale(_language)),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // 美国英语
        Locale('zh', 'CN'), // 中文简体
      ],
      home: HomePage(),
      routes: Router.routers,
    );
  }
}
