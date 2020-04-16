/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_generators1.dart
 * Date:4/16/20, 8:51 AM
 * Author: Denny Zhang
 */

//async*
import 'dart:async';

main(List<String> arguments) {

  genStream().listen((data) {
    print("stream1 : $data");
  });

  genStream2().listen((data) {
    print("stream2 : $data");
  });
}


Stream<int> genStream({int max = 10}) async* {
  int i = 0;
  while (i < max) {
    yield i;
    await Future.delayed(Duration(milliseconds: 300));
    i++;
  }
}

Stream<int> genStream2({int max = 10}) {
  StreamController<int> controller = StreamController();

  Future<void>.delayed(Duration.zero).then((_) async {
    int i = 0;
    while (i < max) {
      controller.add(i);
      await Future.delayed(Duration(milliseconds: 300));
      i++;
    }
    controller.close();
  });

  return controller.stream;
}