/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_generators1.dart
 * Date:4/16/20, 8:51 AM
 * Author: Denny Zhang
 */

//async*

//yield*
main(List<String> arguments) {
  var r = naturalsDownFrom(10);
  print(r); //(10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

  r = naturalsDownWithNormal(10);
  print(r); //(10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
}

Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

Iterable<int> naturalsDownWithNormal(int n) {
  var list = <int>[];
  if (n > 0) {
    list.add(n);
    var r = naturalsDownWithNormal(n - 1);
    list.addAll(r);
  }
  return list.map((v) => v);
}