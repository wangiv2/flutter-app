import 'package:flutter/material.dart';
import 'package:flutter_app/provider/profile_change_notifier.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:provider/provider.dart';

abstract class Funs {
  BuildContext _context;

  void initFuns(BuildContext context) {
    _context = context;
  }

  void consoleLog(Object object) {
    BasePageWidget basePageWidget = _context.widget;
    print("[$basePageWidget] - $object");
  }

  ProfileChangeNotifier profileProvider({bool listen = true}) {
    return Provider.of<ProfileChangeNotifier>(_context, listen: listen);
  }
}
