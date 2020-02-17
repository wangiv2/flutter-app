import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/routers/router.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/utils/share_preferences/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'model/user_preference_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferenceEntity userPref = await SharePreferencesUtil().getUserPreference();
  String _lang;
  if (userPref != null) {
    _lang = userPref.language;
  }
  print("main userPref.language: $_lang");
  runApp(new MyApp(language: _lang,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key key, @required this.language}) : super(key: key);

  final String language;

  @override
  Widget build(BuildContext context) {
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
        FlutterI18nUtil.delegate(this.language),
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
