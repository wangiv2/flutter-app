import 'package:flutter/material.dart';
import 'package:flutter_app/common/funs.dart';
import 'package:flutter_app/pages/opportunity/router.dart';
import 'package:flutter_app/res/app_colors.dart';
import 'package:flutter_app/routers/router_navigator.dart';
import 'package:flutter_app/widgets/base_page_widget/base_page_widget.dart';
import 'package:flutter_app/widgets/base_page_widget/navigationBar_page_widget.dart';
import 'package:flutter_app/config/app_config.dart';
import 'package:flutter_app/samples/router.dart';

class MenuPage extends NavigationBarPageWidget {
  @override
  String getPageName() => "MenuPage";

  @override
  BasePageWidgetState<BasePageWidget> getState() => _MenuPageState();
}

class _MenuPageState extends NavigationBarPageWidgetState<MenuPage> {

  @override
  String getTitle() {
    String title = flutterI18nUtil.translate("homePage.tabTitles.menu");
    return '$title ${AppConfig.getInstance().configEntity.env}';
  }

  @override
  Widget buildContentWidget(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.only(left: 5.0, top: 20.0),
        children: <Widget>[
          _buildListItem(flutterI18nUtil.translate("menuPage.opportunity"), Icons.lightbulb_outline, () {
            RouterNavigator.push(context, OpportunityRouter.listPage);
          }),
          _buildListItem(flutterI18nUtil.translate("menuPage.interaction"), Icons.chat, () {}),
          _buildListItem(flutterI18nUtil.translate("menuPage.contribution"), Icons.access_alarm, () {}),
          _buildListItem(flutterI18nUtil.translate("menuPage.addToCalendar"), Icons.calendar_view_day, () {
            RouterNavigator.push(context, SamplesRouter.addToCalendarPage);
          }),
          _buildListItem(flutterI18nUtil.translate("menuPage.imagePicker"), Icons.image, () {
            RouterNavigator.push(context, SamplesRouter.multiImagePickerPage);
          }),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {

    return new InkWell(
      onTap: action,
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 45.0,
              height: 45.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                color: Funs.isDarkTheme() ? AppColors.dark_app_main : AppColors.app_main,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(iconData, color: Colors.white, size: 24.0),
            ),
            new Text(title),
            new Expanded(child: new Container()),
            new IconButton(
                icon: new Icon(Icons.chevron_right),
                onPressed: action)
          ],
        ),
      ),
    );
  }
}
