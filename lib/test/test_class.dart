/*
 * Copyright(c) 2020,  MBC Team
 * 项目名称:flutter-framework
 * 文件名称:test_class.dart
 * Date:4/14/20, 11:36 AM
 * Author: Denny Zhang
 */

import 'test_factory.dart';

class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {

  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}


main() {
  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  assert(emp is Logger);
  (emp as Person).firstName = 'Bob';

  var logger = Logger('UI');
  logger.log('Button clicked');

}