/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_async1.dart
 * Date:4/15/20, 11:33 AM
 * Author: Denny Zhang
 */

void main() {
  getName1();
  getName2();
  getName3();
  checkVersion();
}

Future checkVersion() async {
  print('checkVersion start');
  var version = await getVersionNumber();
  print('checkVersion completed: ' + version);
}

Future<String> getVersionNumber() async => ("v1.2.0".toLowerCase());

getName1() async {
  await getStr1();
  await getStr2();
  print('getName1');
}

getStr1() async {
  print('getStr1');
}

getStr2() {
  print('getStr2');
}

getName2() {
  print('getName2');
}

getName3() {
  print('getName3');
}