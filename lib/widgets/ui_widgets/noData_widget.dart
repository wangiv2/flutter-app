import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutterI18n/index.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/ic_empty.png"),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(FlutterI18nUtil(context).translate('common.error.noData'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
