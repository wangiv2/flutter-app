import 'package:flutter_app/config/app_config.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'notification_event.dart';

class JPushUtil {
  var registrationID;

  init() async{
    try {
      JPush _push = new JPush();

      _push.setup(
        appKey: AppConfig.getInstance().configEntity.jPushAppKey,
        channel: '',
        production: false,
        debug: true,
      );

      registrationID = await _push.getRegistrationID();

      _push.addEventHandler(
          onReceiveNotification: onReceiveNotification,
          onOpenNotification: onOpenNotification
      );
    } catch (exception) {
      print('JPush init exception:$exception');
    }
  }

  /// when tap the notification will trigger the function.
  Future<dynamic> onReceiveNotification (Map<String,dynamic>message) async {
    print('Receive Notificaiton:$message');
    eventBus.fire(ReceiveNotificationEvent(message));
  }

  /// when receive the notification will trigger the function.
  Future<dynamic> onOpenNotification (Map<String,dynamic>message) async {
    print('Open Notificaiton:$message');
    eventBus.fire(OpenNotificationEvent(message));
  }

}
