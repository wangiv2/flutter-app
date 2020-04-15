/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_async1.dart
 * Date:4/15/20, 11:33 AM
 * Author: Denny Zhang
 */

void main() {
  new Future(() => futureTask())//异步任务的函数
      .then((i) => "result:$i")//任务执行完后的子任务
      .then((m) => print(m)) //其中m为上个任务执行完后的返回的结果
      .then((_) => Future.error("出错了"))
      .catchError(print)
      .whenComplete(() => print("whenComplete"));//所有任务完成后的回调函数
}

futureTask() {
  return 10;
}