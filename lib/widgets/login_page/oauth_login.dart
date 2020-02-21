import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/oauth_entity_entity.dart';
import 'package:flutter_app/utils/http/http_manager.dart';
import 'package:flutter_app/utils/http/http_method.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();

    flutterWebviewPlugin.launch(
        'https://oauth.oocl.com/oauthserver/oauth/authorize?client_id=c733d56d77bb4a888943a8e87886fcf4&redirect_uri=http://mobileoauth/ospapp&response_type=code&state=osp',
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
      print('type ====== $type');
      print('url ====== $url');

      if (type == WebViewState.finishLoad) {
        var str = "\$('#username').attr('placeholder', '用户名');";
        flutterWebviewPlugin.evalJavascript(str);

        print('isFirstLoad ====== $isFirstLoad');
        if (isFirstLoad && url.contains("/loginform")) {
          print('isFirstLoad2333333 ====== $isFirstLoad');
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
          OAuthEntityEntity oauthEntityEntity = await this.getToken(code);
          print('get oauth code .... ${oauthEntityEntity.accessToken}');

          flutterWebviewPlugin.close();

          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  Future<OAuthEntityEntity> getToken(String code) async {
    var params = {
      "client_id": "c733d56d77bb4a888943a8e87886fcf4",
      "client_secret": "bc73e7a7cb7a4281b1be967d3e341e81",
      "grant_type": "authorization_code",
      "redirect_uri": "http://mobileoauth/ospapp",
      "code": code
    };

    var res = await httpManager.netFetch(
        Method.POST, 'https://oauth.oocl.com/oauthserver/oauth/token',
        data: params,
        option: Options(contentType: Headers.formUrlEncodedContentType));
    OAuthEntityEntity oauthResponse = OAuthEntityEntity().fromJson(res.data);
    return oauthResponse;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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
