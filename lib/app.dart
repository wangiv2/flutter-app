import 'package:flutter/material.dart';
import 'package:flutter_app/provider/profile_provider.dart';
import 'package:flutter_app/provider/theme_provider.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';
import 'package:flutter_app/widgets/splash_page/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyApp extends StatelessWidget {
  MyApp(){
    RouterNavigator.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: ThemeProvider()),
      ],
      child: OKToast(
          child: Consumer<ThemeProvider>(
            builder: (_, provider, __) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                themeMode: provider.getThemeMode(),
                localizationsDelegates: [
                  FlutterI18nUtil.delegate('en'),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: FlutterI18nUtil.supportedLocales,
                home: SplashPage(),
              );
            },
          ),
          // toast setting
          backgroundColor: Colors.black54,
          textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          radius: 20.0,
          position: ToastPosition.bottom
      ),
    );
  }
}
