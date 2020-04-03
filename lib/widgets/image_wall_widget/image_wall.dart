import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

typedef void ImagesChangeCallback(List<Asset> newImages);
typedef Future<Asset> UploadImageCallback();

/// 点击删除按钮时的回调
typedef RemoveImageCallback(Asset removedUrl);

//照片墙
class ImageWall extends StatefulWidget {
  final Widget uploadBtn;
  final int rowCount; //item per row
  final int maxCount; //限制上传数量
  final List<Asset> images; //initial images
  final bool reorderable; //是否允许排序
  final ImagesChangeCallback onChange;
  final UploadImageCallback onUpload;
  final RemoveImageCallback onRemove;

  const ImageWall({
    Key key,
    this.rowCount = 3,
    this.maxCount,
    this.images,
    @required this.onChange,
    @required this.onUpload,
    this.uploadBtn,
    this.reorderable = true,
    this.onRemove,
  }) : super(key: key);

  @override
  _ImageWallState createState() => _ImageWallState();
}

class _ImageWallState extends State<ImageWall> {
  List<Asset> images = List<Asset>();

  @override
  void initState() {
    super.initState();
//    images = widget.images ?? new List<Asset>();
  }

  @override
  Widget build(BuildContext context) {
    images = widget.images ?? new List<Asset>();
    final double space = 16.0;
    return InkWell(
      child: GridView.count(
        padding: EdgeInsets.all(space),
        primary: false,
        crossAxisCount: widget.rowCount,
        crossAxisSpacing: space,
        mainAxisSpacing: space,
        children: buildImages(),
      ),
    );
  }

  List<Widget> buildImages() {
    List<Widget> widgets = [];
    for (int i = 0; i < images.length; i++) {
      widgets.add(_buildImageItem(i));
    }
    if (widget.maxCount == null || images.length < widget.maxCount) {
      widgets.add(_buildAddImageButton());
    }
    return widgets;
  }

  Widget _buildImageItem(int index) {
    if (images[index] == null) {
      return CircularProgressIndicator();
    }
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        AssetThumb(
          asset: images[index],
          width: 250,
          height: 250,
        ),
//        Image.network(
//          images[index],
//          fit: BoxFit.cover,
//        ),
        Positioned(
          right: -10.0,
          top: -10.0,
          child: InkWell(
            child: Icon(Icons.cancel, color: Theme.of(context).disabledColor),
            onTap: () {
              Asset removedUrl;
              setState(() {
                removedUrl = images.removeAt(index);
              });
              widget.onChange(images);
              if (widget.onRemove != null) {
                widget.onRemove(removedUrl);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildAddImageButton() {
    Widget btn = Container(
      decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.none,
            color: Theme.of(context).disabledColor,
          ),
          color: Colors.black12),
      child: Icon(
        Icons.add,
        color: Theme.of(context).disabledColor,
        size: 50,
      ),
    );

    return InkWell(
      child: widget.uploadBtn ?? btn,
      onTap: () async {
        loadAssets();
//        Asset url = await widget.onUpload();
//        if (url == null) {
//          return;
//        }
//        setState(() {
//          images.add(url);
//        });
//        widget.onChange(images);
      },
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: widget.maxCount - images.length,
        enableCamera: true,
        selectedAssets: [],
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#"+ AppColors.app_main.value.toRadixString(16),
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#" + AppColors.app_main.value.toRadixString(16),
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
      images.addAll(resultList);
//      images = resultList;
//      _error = error;
    });
  }
}