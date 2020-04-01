import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';

class ErrorPage401 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18nUtil(context).translate('common.error.http401.title'))
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
//      color: Colors.white,
//      width: double.infinity,
//      height: double.infinity,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/ic_error_401.png"),
                  width: 180,
                  height: 180,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(FlutterI18nUtil(context).translate('common.error.http401.content'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
