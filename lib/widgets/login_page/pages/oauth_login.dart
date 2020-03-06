import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http/http_manager.dart';
import 'package:flutter_app/utils/http/http_method.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
import 'package:flutter_app/widgets/login_page/service/oauth_service.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class OAuthLoginPage extends StatefulWidget {
  @override
  _OAuthLoginPageState createState() => _OAuthLoginPageState();
}

class _OAuthLoginPageState extends State<OAuthLoginPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    flutterWebviewPlugin.launch(
        'https://oauth.oocl.com/oauthserver/oauth/authorize?client_id=6a4e409ea4a4441dbd4c6de60523f35c&redirect_uri=http://mobileoauth/easapp&response_type=code&state=eas',
        clearCache: true,
        clearCookies: true,
        hidden: true);

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        Future.microtask(() {
          if (!visible) {
            flutterWebviewPlugin.evalJavascript('window.scrollTo(0, 0)');
          }
        });
      },
    );

    flutterWebviewPlugin.onHttpError.listen((error) {
      print('load error: $error');
    });

    flutterWebviewPlugin.onUrlChanged.listen((url) async {
      print('url2222 ==== $url');
      if (url.contains("#/back_to_select")) {
        setState(() {
          isLoading = false;
        });
        Future.microtask(() {
          flutterWebviewPlugin.close();
        });
      }
    });

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) async {
      var type = state.type;
      var url = state.url;

      if (type == WebViewState.finishLoad) {
        var str = "\$('#username').attr('placeholder', '用户名');";
        flutterWebviewPlugin.evalJavascript(str);

        if (isFirstLoad && url.contains("/loginform")) {
          flutterWebviewPlugin.show();
          setState(() {
            isFirstLoad = false;
          });
        }
      }

      if (type == WebViewState.shouldStart) {
        var map = UrlHelper.parseUrl(url);
        var code = map['code'];

        if (code != null) {
          flutterWebviewPlugin.hide();
          await oauthService.getToken(code);
          flutterWebviewPlugin.close();

          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: UnconstrainedBox(child: CircularProgressIndicator())),
            FlatButton(
              onPressed: () async {
                try {
                  var res = await httpManager.netFetch(Method.GET, "https://eapgateway.oocl.com/api/v1/user/getCurrentUser");
                  var res2 = await httpManager.netFetch(Method.GET, "https://eapgateway.oocl.com/api/v1/user/getCurrentUser");
                  print('res ==== ${res.data}');
                  print('res2 ==== ${res2.data}');
                } catch (e) {
                  print('http error : $e');
                }
              },
              child: Text("Get User"),
            ),
            FlatButton(
              onPressed: () async {
                await oauthService.refreshToken();
              },
              child: Text("Refresh Token"),
            ),
            FlatButton(
              onPressed: () async {
                String token = SpUtil.getString("access_token");
                print('Display Token: $token');
              },
              child: Text("Display Token"),
            ),
            FlatButton(
              onPressed: () async {
                await oauthService.revokeToken();
              },
              child: Text("Revoke Token"),
            ),
            FlatButton(
              onPressed: () async {
                await SpUtil.putString("access_token", "error");
              },
              child: Text("Set Error Access Token"),
            ),
            FlatButton(
              onPressed: () async {
                await SpUtil.putString("access_token", "error");
                await SpUtil.putString("refresh_token", "error");
              },
              child: Text("Set Error All Token"),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}

class UrlHelper {
  static Map<String, String> parseUrl(String url) {
    Uri uri = Uri.dataFromString(url);
    Map<String, String> map = Map<String, String>();
    uri.queryParameters.forEach((key, value) {
      map.addAll({key: value});
    });
    return map;
  }
}
