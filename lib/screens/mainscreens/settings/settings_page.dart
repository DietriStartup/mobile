
import 'package:dietri/components/settings/setting_header.dart';
import 'package:dietri/components/settings/settings_card.dart';

import 'package:dietri/helper/routes.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 20.0, context)),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SettingHeader(title: 'Reminder'),
              SettingsCard(
                tailing: false,
                text: 'Water intake',
                onPressed: () {},
                showSwitch: true,
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'Breakfast',
                onPressed: () {},
                showSwitch: true,
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'Lunch',
                onPressed: () {},
                showSwitch: true,
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'Dinner',
                onPressed: () {},
                showSwitch: true,
              ),
              SizedBox(
                height: sizer(false, 26.0, context),
              ),
              SettingHeader(title: 'Display'),
              SettingsCard(
                tailing: false,
                text: 'Light Mode',
                onPressed: () {},
                showSwitch: true,
              ),
              SizedBox(
                height: sizer(false, 26.0, context),
              ),
              SettingHeader(title: 'General'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.languagePageRoute);
                },
                child: SettingsCard(
                  tailing: true,
                  text: 'Language',
                  buttonText: 'English',
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.languagePageRoute);
                  },
                  showSwitch: false,
                ),
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'Help and Support',
                buttonText: 'English',
                onPressed: () {},
                showSwitch: false,
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'Terms and conditions',
                buttonText: 'English',
                onPressed: () {},
                showSwitch: false,
              ),
              SizedBox(
                height: sizer(false, 5.0, context),
              ),
              SettingsCard(
                tailing: false,
                text: 'About',
                buttonText: 'English',
                onPressed: () {},
                showSwitch: false,
              ),
              SizedBox(
                height: sizer(false, 29.0, context),
              ),
              SizedBox(
                height: sizer(false, 57.0, context),
              )
            ],
          ),
        ),
      )),
    );
  }
}
