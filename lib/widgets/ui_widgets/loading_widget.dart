import 'package:flutter/material.dart';
import 'package:flutter_app/common/funs.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.black12,
      child: Center(
        child:
        new SpinKitFadingCircle(color: Funs.isDarkTheme() ? AppColors.dark_app_main : AppColors.app_main),
      ),
    );
  }
}
