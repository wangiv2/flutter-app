import 'package:flutter/material.dart';
import 'package:flutter_app/config/app_config.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_app/utils/shared_preferences/index.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.getInstance().loadConfigJson('qa');
  UserPreferenceEntity _userPref =
  await SharedPreferencesUtil().getUserPreference();
  await SpUtil.getInstance();
  runApp(new MyApp(userPref: _userPref));
}