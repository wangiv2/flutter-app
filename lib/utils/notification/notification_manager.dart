import 'dart:io';
import 'package:flutter_app/utils/http/http_method.dart';

import 'apns.dart';
import 'jpush.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_app/utils/http/http_manager.dart';

class NotificationManager {

  APNSUtil aPnsUtil;
  JPushUtil jPushUtil;

  ///notification single instance
  static NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => getInstance();
  NotificationManager._internal() {}
  static NotificationManager getInstance() {
    if (_instance == null) {
      _instance = new NotificationManager._internal();
    }
    return _instance;
  }

  /// notification set up function
  void setup() async{
    if (Platform.isIOS){
     aPnsUtil = APNSUtil();
     aPnsUtil.init();
    }else{
     jPushUtil = JPushUtil();
     jPushUtil.init();
    }
  }

  /// notification subscribe & unsubscribe function
  void notificationAction({String action, String topicString, successCallBack, errorCallBack}) async{
    var deviceToken;
    var uuid;
    var model;
    var notificationChannelName;

    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS){
      deviceToken = aPnsUtil.deviceToken;
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      uuid = iosInfo.identifierForVendor;
      model = iosInfo.model;
      notificationChannelName = 'IOS';
    }else{
      deviceToken = jPushUtil.registrationID;
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      uuid = androidInfo.androidId;
      model = androidInfo.model;
      notificationChannelName = 'Android';
    }

    var params = {
      "appID": "27094a80-6ca7-11ea-8988-436fd581cfc5",
      "oldDeviceToken": deviceToken,
      "deviceToken": deviceToken,
      "action": action,
      "notiChannelName": notificationChannelName,
      "topicString": topicString,
      "subscribeUser": "",
      "deviceTargetType": 0,
      "prodFlag": 0,
      "deviceUUID": uuid,
      "deviceModel": model
    };

    var response = await httpManager.netFetch(
        Method.GET, 'http://hkgcvdv80128.oocl.com:6003/nj_prs_notification/api/subscribe/apiAdvance',
        data: params);
    if (response.data['success'] == true){
      if (successCallBack != null){
        successCallBack();
      }
    }else{
      if (errorCallBack != null){
        errorCallBack('error');
      }
    }
  }

}