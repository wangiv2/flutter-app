/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_async1.dart
 * Date:4/15/20, 11:33 AM
 * Author: Denny Zhang
 */

void main(){
  testFuture();
}
void testFuture() {
  Future f = new Future(() => print('f1'));
  Future f1 = new Future(() => null);
  Future f2 = new Future(() => null);
  Future f3 = new Future(() => null);
  f3.then((_) => print('f2'));
  f2.then((_) {
    print('f3');
    new Future(() => print('f4'));
    f1.then((_) {
      print('f5');
    });
  });
  f1.then((m) {
    print('f6');
  });
  print('f7');
}