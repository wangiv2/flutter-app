import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';

class LoginPage extends BasePageWidget {
  @override
  String getPageName() {
    return "LoginPage";
  }

  @override
  BasePageWidgetState<BasePageWidget> getState() {
    return _LoginPageState();
  }


}

class _LoginPageState extends BasePageWidgetState<LoginPage> {
  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    return Container();
  }

  @override
  String getTitle() {
    // TODO: implement getTitle
    return null;
  }

}
