import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/opportunity/entities/opportunity_entity.dart';
import 'package:flutter_app/pages/opportunity/repository/opportunity_repo.dart';
import 'package:flutter_app/pages/opportunity/res/constants.dart';
import 'package:flutter_app/pages/opportunity/router.dart';
import 'package:flutter_app/widgets/base_page_widget/list_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/search_page_widget/common_search_delegate.dart';
import 'package:flutter_app/widgets/search_page_widget/search_page_delegate.dart';

class OpportunityListPage extends BaseListPageWidget{
  @override
  String getPageName() => "OpportunityPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _OpportunityListPageState();

}

class _OpportunityListPageState extends BaseListPageWidgetState<OpportunityListPage> {

  @override
  bool get enableRefresh => true;

  @override
  bool get enableLoadMore => true;

  @override
  String getTitle() => flutterI18nUtil.translate("menuPage.opportunity");

  @override
  List<Widget> getAppBarActions(context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: gotoSearchPage,
      ),
    ];
  }

  @override
  String getDetailPageRouter() => OpportunityRouter.detailPage;

  @override
  Widget buildItem(dynamic item) {
    return _getListItem(item);
  }

  Widget _getListItem(OpportunityEntity item) {
    return SizedBox(
      child: Card(
        elevation: 5.0,  //设置阴影
        child: Column(  // card只能有一个widget，但这个widget内容可以包含其他的widget
          children: [
            ListTile(
              title: Text(
                  item.title,
                  style: TextStyle(fontWeight: FontWeight.w500)
              ),
              subtitle: Text(item.subTitle),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
                size: 34.0,
              ),
              trailing: Text(item.dateTime),
            ),
            ListTile(
              title: Text(item.content),
              trailing: item.isApproved ? Icon(Icons.check_circle, color: Colors.green, size: 20.0,): Container(width: 0, height: 0,),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future loadData({int index = 0}) {
    return OpportunityRepo.getList(index).then((list) {
      return list;
    });
  }

  void gotoSearchPage() {
    showSearchPage(
        context: context,
        delegate: CommonSearchDelegate(
          historySpKey: Constants.sp_key_opportunity_list,
          onSearch: (query) async {
            consoleLog('onSearch: $query');
            return OpportunityRepo.getList(0);
          },
          buildResultItem: (BuildContext context, int index, Object item) {
            OpportunityEntity opportunity = item;
            return _getListItem(opportunity);
          }
        )
    );
  }
}
