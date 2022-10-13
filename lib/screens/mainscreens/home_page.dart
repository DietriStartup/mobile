import 'package:dietri/models/user.dart';
import 'package:dietri/screens/mainscreens/home.dart';
import 'package:dietri/screens/mainscreens/cupertino_tab_scaffold.dart';
import 'package:dietri/screens/mainscreens/explore.dart';

import 'package:dietri/screens/mainscreens/profile.dart';
import 'package:dietri/screens/saved_meals.dart';
import 'package:flutter/material.dart';

import '../../models/tab_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.explore: GlobalKey<NavigatorState>(),
    // TabItem.settings: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => Home(
            userModel: widget.userModel,
          ),
      TabItem.explore: (_) => ExplorePage.create(context),
      TabItem.savedmeals: (_) => SavedMealsPage.create(context),
      //TabItem.settings: (context) => const SettingsPage(),
      TabItem.profile: (_) => ProfilePage.create(context, widget.userModel)
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
      ),
    );
  }
}
