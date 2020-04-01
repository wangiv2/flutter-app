import 'package:flutter/material.dart';
import 'package:flutter_app/config/app_config.dart';
import 'package:flutter_app/app.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.getInstance().loadConfigJson('prod');
  runApp(new MyApp());
}
