import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';

class OpportunityDetailPage extends NavigationBarPageWidget {
  @override
  String getPageName() => "OpportunityDetailPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _OpportunityDetailPageState();

}

class _OpportunityDetailPageState extends NavigationBarPageWidgetState<OpportunityDetailPage> {

  String _content = "";

  @override
  void onCreate() async {
    super.onCreate();
    showLoadingWidget();
    await _getData();
    _content = "Detail page: $pageParams";
    setState(() {});
    hideLoadingWidget();
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Center(
      child: Text(_content),
    );
  }

  @override
  String getTitle() {
    return pageParams;
  }

  Future _getData() {
    return Future.delayed(Duration(seconds: 1));
  }

}
