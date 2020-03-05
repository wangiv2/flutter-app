import 'package:flutter/material.dart';

class ErrorPage404 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404")
      ),
      body: Center(
        child: Text('404 Not found'),
      ),
    );
  }
}
