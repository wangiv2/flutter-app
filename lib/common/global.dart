import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/json/profile_entity_helper.dart';
import 'package:flutter_app/entities/profile_entity.dart';
import 'package:flutter_app/res/constants.dart';

class Global {
  static ProfileEntity profile = ProfileEntity();

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
