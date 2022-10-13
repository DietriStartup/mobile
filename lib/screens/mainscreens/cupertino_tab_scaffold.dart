import 'package:dietri/constants/colors.dart';
import 'package:dietri/helper/routes.dart';
import 'package:dietri/models/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          onGenerateRoute: Routes.generateRoute,
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item]!(context),
        );
      },
      tabBar: CupertinoTabBar(
        inactiveColor: Colors.grey,
        activeColor: kPrimaryAccentColor,
        backgroundColor: Colors.white,
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.explore),
          _buildItem(TabItem.savedmeals),
        //  _buildItem(TabItem.settings),
          _buildItem(TabItem.profile)
        ],
        onTap: (index) {
          onSelectTab(TabItem.values[index]);
        },
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabItems[tabItem];
    final color = currentTab == tabItem ? kPrimaryAccentColor : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData!.icon,
        size: 25,
        color: color,
      ),
      //label: itemData.title,
      backgroundColor: color,
    );
  }
}
