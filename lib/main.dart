import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/routers/router.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/utils/share_preferences/index.dart';
import 'package:flutter_app/widgets/login_page/common_login.dart';
import 'package:flutter_app/widgets/splash_page/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'model/user_preference_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferenceEntity _userPref = await SharePreferencesUtil().getUserPreference();
  runApp(new MyApp(userPref: _userPref));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key key, @required this.userPref}) : super(key: key);

  final UserPreferenceEntity userPref;

  @override
  Widget build(BuildContext context) {
    String _lang = userPref?.language;
    bool _isFirstLaunch = userPref?.isFirstLaunch == null;
    bool _isLogin = userPref?.isLogin != null;
    print("userPref: language[$_lang] isFirstLaunch[$_isFirstLaunch] isLogin[$_isLogin]");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      localizationsDelegates: [
        FlutterI18nUtil.delegate(_lang),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // 美国英语
        Locale('zh', 'CN'), // 中文简体
      ],
      home: _getHomePage(_isFirstLaunch, _isLogin),
      routes: Router.routers,
    );
  }

  dynamic _getHomePage(bool _isFirstLaunch, bool _isLogin) {
    SplashPage _splashPage = SplashPage(
      imageList: [
        'assets/images/splash_1.png',
        'assets/images/splash_2.png',
        'assets/images/splash_3.png',
      ],
      redirectPage: _isLogin ? HomePage() : LoginPage(),
    );
    if (_isFirstLaunch) {
      return _splashPage;
    } else if (_isLogin) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
