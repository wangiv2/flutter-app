import 'package:flutter/material.dart';

class ListItemChangeNotifier extends ChangeNotifier {
  List<dynamic> _list = [];

  List<dynamic> get list => _list;
  set list(List<dynamic> list) {
    _list = list;
    notifyListeners();
  }

  void addItems(List<dynamic> items) {
    _list.addAll(items);
    notifyListeners();
  }

  void addItem(dynamic item) {
    _list.add(item);
    notifyListeners();
  }

  void removeItem(dynamic item) {
    _list.remove(item);
    notifyListeners();
  }

  void removeLastItems() {
    _list.removeLast();
    notifyListeners();
  }

  void clearItems() {
    _list.clear();
    notifyListeners();
  }

  void updateItem(dynamic item) {
    _list.forEach((value) {
      if (value == item) {
        print(value);
      }
    });
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}


