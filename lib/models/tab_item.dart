import 'package:dietri/components/dietre_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TabItem { home, explore, savedmeals, settings, profile }

class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabItems = {
    TabItem.home: TabItemData(icon: Dietre.newhome, title: 'Home'),
    TabItem.savedmeals:
        TabItemData(title: 'Saved Meals', icon: Icons.bookmark_outline_rounded),
    TabItem.explore: TabItemData(icon: Dietre.search_normal, title: 'Explore'),
    TabItem.settings: TabItemData(icon: Dietre.setting_2, title: 'Settings'),
    TabItem.profile: TabItemData(icon: Dietre.profile_circle, title: 'Profile'),
  };
}
