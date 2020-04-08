import 'package:fluro/fluro.dart';
import 'package:flutter_app/samples/calendar/add_to_calendar_page.dart';
import 'package:flutter_app/samples/imagePicker/multi_image_picker_page.dart';
import 'package:flutter_app/routers/routers.dart';


class SamplesRouter implements IRouter{

  static String addToCalendarPage = '/sample/addToCalendarPage';
  static String multiImagePickerPage = '/sample/multiImagePickerPage';

  @override
  void initRouter(Router router) {
    router.define(addToCalendarPage, handler: Handler(handlerFunc: (_, params) => AddToCalendarPage()));
    router.define(multiImagePickerPage, handler: Handler(handlerFunc: (_, params) => MultiImagePickerPage()));
  }

}
