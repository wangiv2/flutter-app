/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_async1.dart
 * Date:4/15/20, 11:33 AM
 * Author: Denny Zhang
 */

import 'dart:async';

void main(){
  testScheduleMicrotask();
}
void testScheduleMicrotask(){
  scheduleMicrotask(() => print('s1'));//微任务
  //delay 延迟
  new Future.delayed(new Duration(seconds: 1), () => print('s2'));

  new Future(() => print('s3')).then((_) {
    print('s4');
    scheduleMicrotask(() => print('s5'));
  }).then((_) => print('s6'));

  new Future(() => print('s7'));

  scheduleMicrotask(() => print('s8'));

  print('s9');
}