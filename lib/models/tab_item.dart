import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TabItem { home, explore, settings, profile }

class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabItems = {
    TabItem.home: TabItemData(icon: Icons.home_outlined, title: 'Home'),
    TabItem.explore: TabItemData(icon: Icons.search_outlined, title: 'Explore'),
    TabItem.settings:
        TabItemData(icon: Icons.settings_outlined, title: 'Settings'),
    TabItem.profile:
        TabItemData(icon: Icons.person_outline_outlined, title: 'Profile'),
  };
}
