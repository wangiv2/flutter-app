import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/json/profile_entity_helper.dart';
import 'package:flutter_app/entities/profile_entity.dart';
import 'package:flutter_app/res/constants.dart';

// 提供四套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.teal,
];

class Global {
  static ProfileEntity profile = ProfileEntity();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;


  // 获取Profile信息
  static Future getProfile() async {
    await SpUtil.getInstance();
    Map<String, dynamic> value = SpUtil.getObject(Constants.sp_key_profile);
    if (value != null) {
      profileEntityFromJson(profile, value);
    }
    print('Profile: ${profile.toJson()}');
  }

  // 持久化Profile信息
  static saveProfile() async {
    await SpUtil.putObject(Constants.sp_key_profile, profile);
  }

}
