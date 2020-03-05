import 'package:flutter/material.dart';

class ErrorPage401 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("401")
      ),
      body: Center(
        child: Text('401 Unauthorized'),
      ),
    );
  }
}
