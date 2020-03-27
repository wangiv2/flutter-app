import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/entities/user_entity.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/routers/routers.dart';

double adapterHeight(double size) {
  return ScreenUtil.getInstance().getHeight(size);
}

class CommonLoginPage extends StatelessWidget {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: adapterHeight(100)),
                child: Center(
                  child: Image.asset('assets/images/oocl.png',
                      width: 200, height: 100),
                ),
              ),
              LoginInputField(
                  title: 'ACCOUNT',
                  hintText: 'Please input your account',
                  controller: accountController),
              Divider(
                height: 20.0,
              ),
              LoginInputField(
                  title: 'PASSWORD',
                  hintText: 'Please input your password',
                  controller: passwordController,
                  obscureText: true),
              Divider(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 20.0, bottom: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          Global.profile.user = new UserEntity(
                              account: 'wangiv2',
                              englishName: 'Ivan Wang',
                              chineseName: '王志鹏',
                              title: 'STE',
                              email: 'Ivan.wang@oocl.com');
                          print(
                              'Login with ${Global.profile.user.toJson().toString()}');
                          Global.saveProfile();
                          RouterNavigator.push(context, Routes.home,
                              replace: true,
                              clearStack: true,
                              transition: TransitionType.fadeIn);
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
      ),
    );
  }
}

class LoginInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const LoginInputField(
      {Key key,
      this.title,
      this.hintText,
      this.obscureText = false,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () => {controller.clear()},
                icon: Icon(Icons.clear),
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
            ),
          ),
        )
      ],
    );
  }
}
