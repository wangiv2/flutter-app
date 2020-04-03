import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';

class AddToCalendarPage extends NavigationBarPageWidget {
  @override
  String getPageName() => "AddToCalendarPage";

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() => _AddToCalendarPageState();

}

class _AddToCalendarPageState extends NavigationBarPageWidgetState<AddToCalendarPage> {

  @override
  String getTitle() {
    return FlutterI18n.translate(context, "menuPage.addToCalendar");
  }

  @override
  void onCreate() async {
    super.onCreate();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    Event event = Event(
      title: 'Test event',
      description: 'example',
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 1)),
      allDay: false,
    );

    return Center(
      child: RaisedButton(
        child: Text('Add test event to device calendar'),
        onPressed: () {
          Add2Calendar.addEvent2Cal(event).then((success) {
            consoleLog('addEvent2Cal result' + success.toString());
          });
        },
      ),
    );
  }
}
