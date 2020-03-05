import 'package:flutter/material.dart';

class ErrorPage500 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("500")
      ),
      body: Center(
        child: Text('500 Error'),
      ),
    );
  }
}
