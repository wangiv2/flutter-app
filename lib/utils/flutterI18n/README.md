# Flutter i18n Util
The main goal of flutter i18n util is to simplify the flutter i18n process in Flutter.

## Language Files
Create language json files in `assets/locales` folder.
Samples:
> en.json
> ```Json
> {
>   "homePage": {
>     "title": "Home Page",
>     "tabTitles": {
>       "menu": "Menu"
>     }
>   }
> }
> ```

> zh.json
> ```Json
> {
>   "homePage": {
>     "title": "主页",
>     "tabTitles": {
>       "menu": "菜单"
>     }
>   }
> }
> ```

## Usage
### 1. Add delegate to localizationsDelegates in main.dart file
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ...省略无关代码
      localizationsDelegates: [
        FlutterI18nUtil.delegate('en'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      ...省略无关代码
    );
  }
}
```

### 2. Init context
```dart
FlutterI18nUtil _flutterI18nUtil = new FlutterI18nUtil(_context);
```

### 3. Using Translate function to get locale showing text
```dart
flutterI18nUtil.translate("homePage.title");
```

Special usage plural
```json
{
  "clicked": {
    "times-0": "Not clicked yet!",
    "times-1": "You clicked {time} time!",
    "times-2": "You clicked {times} times!"
  }
}
```

```dart
// Not clicked yet!
flutterI18nUtil.translate("clicked.times", 0);
// You clicked 1 time!
flutterI18nUtil.translate("clicked.times", 1);
// You clicked 3 times!
flutterI18nUtil.translate("clicked.times", 3);
```

#### 4. Refresh language showing
```dart
flutterI18nUtil.refresh(lang: 'en');
flutterI18nUtil.refresh(locale: new Locale('en'));
```
