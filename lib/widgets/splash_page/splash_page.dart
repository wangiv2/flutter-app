import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/routers/routers.dart';
import 'package:flutter_app/utils/shared_preferences/index.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
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
  bool _isFirstLaunch = false;
  bool _isLogin = false;
  double _swiperOpacity = 0.0;
  String _loadingText = '';

  final String _launchImage = 'assets/images/splash/splash_0.png';
  final List<String> _splashImages = [
    'assets/images/splash/splash_1.png',
    'assets/images/splash/splash_2.png',
    'assets/images/splash/splash_3.png',
  ];

  Future _initFunction() async {
    // Get value from SP
    await SpUtil.getInstance();
    UserPreferenceEntity pref = await SharedPreferencesUtil().getUserPreference();
    String _lang = pref?.language;
    _isFirstLaunch = pref?.isFirstLaunch == null;
    _isLogin = pref?.isLogin != null;
    _isFirstLaunch = false; // TODO: need to remove
    _isLogin = true; // TODO: need to remove
    consoleLog("initFunction userPref: language[$_lang] isFirstLaunch[$_isFirstLaunch] isLogin[$_isLogin]");
    flutterI18nUtil.refresh(lang: _lang);

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
    RouterNavigator.present(context, LoginRouter.commonLogin);
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
            _buildSwiperImage(),
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
                fontWeight: FontWeight.bold,
                fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
  Widget _buildSwiperImage() {
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
