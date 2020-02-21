import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  String imagePath = 'assets/images/';
  List<String> _guideList = ['splash_1.png', 'splash_2.png', 'splash_3.png'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
//      await SpUtil.getInstance();
      // 由于SpUtil未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。
//      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
//      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
//        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
//        _guideList.forEach((image) {
//          precacheImage(ImageUtils.getAssetImage(image), context);
//        });
//      }
      _guideList.forEach((image) {
        precacheImage(AssetImage(imagePath + image), context);
      });
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _initGuide();
//    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) {
//      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
//        SpUtil.putBool(Constant.keyGuide, false);
//        _initGuide();
//      } else {
//        _goLogin();
//      }
//    });
  }

  _goLogin() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }), (router) => router == null);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
//      color: ThemeUtils.getBackgroundColor(context),
        child: Swiper(
      key: const Key('swiper'),
      itemCount: _guideList.length,
      loop: false,
      itemBuilder: (_, index) {
        return Image.asset(
          imagePath + _guideList[index],
          key: Key(_guideList[index]),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
//          return LoadAssetImage(
//            _guideList[index],
//            key: Key(_guideList[index]),
//            fit: BoxFit.cover,
//            width: double.infinity,
//            height: double.infinity,
//          );
      },
      onTap: (index) {
        if (index == _guideList.length - 1) {
          _goLogin();
        }
      },
    ));
  }
}
