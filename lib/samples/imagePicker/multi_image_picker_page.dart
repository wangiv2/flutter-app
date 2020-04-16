import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_app/widgets/image_wall_widget/image_wall.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';

class MultiImagePickerPage extends NavigationBarPageWidget {
  @override
  String getPageName() => "MultiImagePickerPage";

  @override
  NavigationBarPageWidgetState<NavigationBarPageWidget> getState() => _MultiImagePickerPageState();
}

class _MultiImagePickerPageState extends NavigationBarPageWidgetState<MultiImagePickerPage> {
  List<Asset> images = List<Asset>();
  String _error;

  @override
  String getTitle() {
    return FlutterI18n.translate(context, "menuPage.imagePicker");
  }

  @override
  void onCreate() async {
    super.onCreate();
  }

  Widget buildImageWall() {
    return Container(
      child: ImageWall(
          maxCount: 9,
          images: images,
          onChange: (images) {
            print(images);
          },
          onUpload: () async {
            await Future.delayed(Duration(seconds: 0));
            return;
          }),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: flutterI18nUtil.translate("menuPage.addToCalendar"),
          allViewTitle: flutterI18nUtil.translate("menuPage.imagePicker"),
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: buildImageWall(),
        )
      ],
    );
  }
}

