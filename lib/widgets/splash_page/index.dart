import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplashPage extends StatefulWidget {
  final List<String> imageList;
  final dynamic redirectPage;

  SplashPage({Key key, @required this.imageList, @required this.redirectPage}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Cache images to avoid flicker caused by the first load
      this.widget.imageList.forEach((image) {
        precacheImage(AssetImage(image), context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
//      color: ThemeUtils.getBackgroundColor(context),
        child: Swiper(
            key: const Key('swiper'),
            itemCount: this.widget.imageList.length,
            loop: false,
            itemBuilder: (_, index) {
              return Image.asset(
                this.widget.imageList[index],
                key: Key(this.widget.imageList[index]),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
            pagination: new SwiperPagination(
                margin: EdgeInsets.all(40.00)
            ),
            onTap: (index) {
              if (index == this.widget.imageList.length - 1) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                  return this.widget.redirectPage;
                }), (router) => router == null);
              }
            },
        )
    );
  }
}
