import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';

class ErrorPage404 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18nUtil(context).translate('common.error.http404.title'))
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
                  image: AssetImage("assets/images/ic_error_404.png"),
                  width: 256,
                  height: 256,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(FlutterI18nUtil(context).translate('common.error.http404.content'),
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
