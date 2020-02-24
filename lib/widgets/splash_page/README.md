# Splash Page
Provide splash page widget to easy use in application.

### Constructor 
```dart
    SplashPage(List<String> imageList, dynamic redirectPage);
```

### Demo
```dart
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        ... 省略无关代码
        home: _getHomePage(_isFirstLaunch, _isLogin)
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
```

