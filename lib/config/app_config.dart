import 'package:flutter_app/model/config_entity.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' as convert;

class AppConfig  {
  static AppConfig _instance;
  factory AppConfig() => getInstance();
  ConfigEntity configEntity;

  AppConfig._internal() {}

  static AppConfig getInstance() {
    if (_instance == null) {
      _instance = new AppConfig._internal();
    }
    return _instance;
  }

  Future<ConfigEntity> loadConfigJson(env) async {
    var configJsonStr = await rootBundle.loadString('lib/config/config.json');
    var configJson = convert.jsonDecode(configJsonStr)[env];
    configEntity = ConfigEntity().fromJson(configJson);
    return configEntity;
  }

}
