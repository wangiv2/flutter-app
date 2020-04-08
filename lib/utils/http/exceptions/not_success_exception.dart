/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException(String msg) {
    message = msg;
  }

  @override
  String toString() {
    return 'NotExpectedException{message: $message}';
  }
}
