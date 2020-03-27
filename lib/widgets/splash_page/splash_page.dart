import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/global.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/login_page/router.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends BasePageWidget {
  @override
  String getPageName() => 'SplashPage';

  @override
  BasePageWidgetState<BasePageWidget> getState() => _SplashPageState();
}

class _SplashPageState extends BasePageWidgetState<SplashPage> {
  bool _isFirstLaunch;
  bool _isLogin;
  double _swiperOpacity = 0.0;
  String _loadingText = '';

  final String _launchImage = 'assets/images/splash/splash_0.png';
  final List<String> _splashImages = [
    'assets/images/splash/splash_1.png',
    'assets/images/splash/splash_2.png',
    'assets/images/splash/splash_3.png',
  ];

  Future _initFunction() async {
    // 使用 ScreenUtil 需要设置设计稿的高宽,这里 750 * 1334 是 iphone6 的 size
    setDesignWHD(750, 1334);
    // Get profile from SP
    await Global.getProfile();

    _isFirstLaunch = Global.profile.isFirstLaunch;
    _isLogin = Global.profile.user != null;
    flutterI18nUtil.refresh(lang: Global.profile.locale);

    // update loading text
    await Future.delayed(Duration(milliseconds: 100));
    _loadingText = flutterI18nUtil.translate('splashPage.loading');
    setState(() {});

    // do the time-consuming operation
    await Future.delayed(Duration(seconds: 2));
  }
  void _gotoHomePage() {
    consoleLog('gotoHomePage');
    RouterNavigator.push(context, Routes.home, replace: true, clearStack: true, transition: TransitionType.fadeIn);
  }
  void _gotoLoginPage() {
    consoleLog('gotoLoginPage');
    RouterNavigator.push(context, LoginRouter.commonLogin, replace: true, clearStack: true, transition: TransitionType.fadeIn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Cache images to avoid flicker caused by the first load
      _splashImages.forEach((image) {
        precacheImage(AssetImage(image), context);
      });
      // Call app init function
      await _initFunction();
      // get the value after init function from sp
      if (_isFirstLaunch) {
        _swiperOpacity = 1.0;
        setState(() {});
      } else if (_isLogin){
        _gotoHomePage();
      } else {
        _gotoLoginPage();
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Material(
//      color: ThemeUtils.getBackgroundColor(context),
        child: Stack(
          children: <Widget>[
            _buildLaunchImage(),
            _buildSwiperImage(context),
          ],
        )
    );
  }

  Widget _buildLaunchImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Image.asset(
          _launchImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 20.0,
          child: Text(
            _loadingText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
  Widget _buildSwiperImage(BuildContext context) {
    return AnimatedOpacity(
      opacity: _swiperOpacity,
      duration: Duration(milliseconds: 200),
      child: Swiper(
        key: const Key('swiper'),
        itemCount: _splashImages.length,
        loop: false,
        itemBuilder: (_, index) {
          return Image.asset(
            _splashImages[index],
            key: Key(_splashImages[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
        pagination: new SwiperPagination(
            margin: EdgeInsets.all(40.00)
        ),
        onTap: (index) {
          if (index == _splashImages.length - 1) {
            // update isFirstLaunch status
            profileProvider(listen: false).isFirstLaunch = false;
            if (_isLogin) {
              _gotoHomePage();
            } else {
              _gotoLoginPage();
            }
          }
        },
      ),
    );
  }
}
