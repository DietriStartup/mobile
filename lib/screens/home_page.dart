import 'package:dietri/screens/explore.dart';
import 'package:dietri/screens/home.dart';
import 'package:dietri/screens/home/cupertino_tab_scaffold.dart';
import 'package:dietri/screens/profile.dart';
import 'package:dietri/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';

import '../models/tab_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    TabItem.settings: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => const Home(),
      TabItem.explore: (_) => const ExplorePage(),
      TabItem.settings: (context) => const SettingsPage(),
      TabItem.profile: (_) => const ProfilePage()
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
