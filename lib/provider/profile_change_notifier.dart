import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/model/profile_entity.dart';
import 'package:flutter_app/model/user_entity.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  ProfileEntity get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class ProfileModel extends ProfileChangeNotifier {
  bool get isFirstLaunch => _profile.isFirstLaunch;
  set isFirstLaunch(bool isFirstLaunch) {
    _profile.isFirstLaunch = isFirstLaunch;
    notifyListeners();
  }

  String get theme => _profile.theme;
  set theme(String theme) {
    _profile.theme = theme;
    notifyListeners();
  }

  String get locale => _profile.locale;
  set locale(String locale) {
    _profile.locale = locale;
    notifyListeners();
  }

  UserEntity get user => _profile.user;
  bool get isLogin => user != null;

  set user(UserEntity user) {
    _profile.user = user;
    notifyListeners();
  }
}

