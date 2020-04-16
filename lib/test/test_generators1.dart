/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_generators1.dart
 * Date:4/16/20, 8:51 AM
 * Author: Denny Zhang
 */

//sync*
main(List<String> arguments) {
  print(genList());
  print(genList2());
}

Iterable<int> genList({int max = 10}) sync* {
  var i = 0;
  while (i < max) {
    yield i;
    i++;
  }
}

Iterable<int> genList2({int max = 10}) {
  var list = <int>[];
  var i = 0;
  while (i < max) {
    list.add(i);
    i++;
  }
  return list.map((i) => i);
}