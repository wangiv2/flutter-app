import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_preference_entity.dart';
import 'package:flutter_app/pages/home/router.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/utils/shared_preferences/index.dart';
import 'package:flutter_app/utils/shared_preferences/sp_util.dart';
import 'package:flutter_app/widgets/login_page/router.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isFirstLaunch = false;
  bool _isLogin = false;
  double _swiperOpacity = 0.0;
  String _loadingText = "Loading...";

  final String _launchImage = 'assets/images/splash/splash_0.png';
  final List<String> _splashImages = [
    'assets/images/splash/splash_1.png',
    'assets/images/splash/splash_2.png',
    'assets/images/splash/splash_3.png',
  ];

  Future _initFunction() async {
    RouterNavigator.init();

    // Get value from SP
    await SpUtil.getInstance();
    UserPreferenceEntity pref = await SharedPreferencesUtil().getUserPreference();
    String _lang = pref?.language;
    _isFirstLaunch = pref?.isFirstLaunch == null;
    _isLogin = pref?.isLogin != null;
    _isFirstLaunch = false;
    _isLogin = true;
    print("initFunction userPref: language[$_lang] isFirstLaunch[$_isFirstLaunch] isLogin[$_isLogin]");
    FlutterI18n.refresh(context, new Locale(_lang));

    // testing
    await Future.delayed(Duration(seconds: 2));
  }
  void _gotoHomePage() {
    print('gotoHomePage');
    RouterNavigator.push(context, HomeRouter.homePage, replace: true, clearStack: true, transition: TransitionType.fadeIn);
  }
  void _gotoLoginPage() {
    print('gotoLoginPage');
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
  Widget build(BuildContext context) {
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
          bottom: 100.0,
          child: Text(
            _loadingText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
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