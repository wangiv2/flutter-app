import 'package:flutter_app/entities/config_entity.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' as convert;
import 'config_json.dart';

class AppConfig  {
  static AppConfig _instance;
  factory AppConfig() => getInstance();
  ConfigEntity configEntity;

  AppConfig._internal();

  /// app single instance
  static AppConfig getInstance() {
    if (_instance == null) {
      _instance = new AppConfig._internal();
    }
    return _instance;
  }

  /// load config function
  Future<ConfigEntity> loadConfigJson(env) async {
    try {
      var configMap = getConfigJson();
      var envItem = configMap[env];
      configEntity = ConfigEntity().fromJson(envItem);
      return configEntity;
    }catch(e){
      //will handle later
    }
  }

}
