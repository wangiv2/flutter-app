import 'package:flutter_apns/apns.dart';
import 'notification_event.dart';

class APNSUtil {
  var deviceToken;

  init() async{
    try {
      final connector = createPushConnector();
      connector.configure(
        onLaunch: onOpenNotification,
        onResume: onReceiveNotification,
        onMessage: onReceiveNotification,
      );
      connector.token.addListener(() {
        if(connector.token.value != null){
          deviceToken = connector.token.value;
        }
      });
      connector.requestNotificationPermissions();

    } catch (exception) {
      print('JPush init exception:$exception');
    }
  }

  /// when tap the notification will trigger the function.
  Future<dynamic> onOpenNotification(Map<String, dynamic> message) async {
    print('Open Notificaiton:$message');
    eventBus.fire(OpenNotificationEvent(message));
  }

  /// when receive the notification will trigger the function.
  Future<dynamic> onReceiveNotification(Map<String, dynamic> message) async {
    print('Receive Notificaiton:$message');
    eventBus.fire(ReceiveNotificationEvent(message));
  }

}
