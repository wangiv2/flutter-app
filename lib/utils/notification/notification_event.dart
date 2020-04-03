import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ReceiveNotificationEvent {
  Map<String,dynamic> message;

  ReceiveNotificationEvent(this.message);
}

class OpenNotificationEvent {
  Map<String,dynamic> message;

  OpenNotificationEvent(this.message);
}