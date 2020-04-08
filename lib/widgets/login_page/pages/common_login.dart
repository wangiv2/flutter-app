import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/entities/user_entity.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/routers/routers.dart';

class CommonLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(100.0),
              child: Center(
                child: Image.asset('assets/images/oocl.png', width: 200, height: 100),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  "ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 6.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.clear),
                  ),
                  border: InputBorder.none,
                  hintText: 'cody.chen@oocl.com',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                ),
              ),
            ),
            Divider(
              height: 24.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 6.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.clear),
                  ),
                  border: InputBorder.none,
                  hintText: '******',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                ),
              ),
            ),
            Divider(
              height: 24.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () async {
//                        print('hello .... ');
//                        var res = await httpManager.netFetch(Method.GET, "http://localhost:3000/service-request?pageNumber=0&pageSize=2");
//                        print('res: $res');
                        Global.profile.user = new UserEntity(
                            account: 'wangiv2',
                            englishName: 'Ivan Wang',
                            chineseName: '王志鹏',
                            title: 'STE',
                            email: 'Ivan.wang@oocl.com'
                        );
                        print('Login with ${Global.profile.user.toJson().toString()}');
                        Global.saveProfile();
                        RouterNavigator.push(context, Routes.home, replace: true, clearStack: true, transition: TransitionType.fadeIn);
                        return null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
