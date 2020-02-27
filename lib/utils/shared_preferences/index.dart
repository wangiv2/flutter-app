import 'dart:convert';

import 'package:flutter_app/generated/json/user_preference_entity_helper.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {

  getUserPreference() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userPreferenceStr = sp.getString("userPreference");
    if (userPreferenceStr == null) {
      return null;
    }
    UserPreferenceEntity _userPreference = new UserPreferenceEntity();
    userPreferenceEntityFromJson(_userPreference, jsonDecode(userPreferenceStr));
    return _userPreference;
  }

  void setUserPreference(UserPreferenceEntity value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonValue = userPreferenceEntityToJson(value);
    String userPreferenceStr = jsonEncode(jsonValue);
    sp.setString("userPreference", userPreferenceStr);
  }
}
