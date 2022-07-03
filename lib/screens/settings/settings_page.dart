import 'package:dietri/components/settings/language_tiles.dart';
import 'package:dietri/components/settings/setting_header.dart';
import 'package:dietri/components/settings/settings_card.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/enum/language.dart';
import 'package:dietri/helper/routes.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:TextButton.icon(
          onPressed: (() => Navigator.of(context).pop()), 
          icon: Icon(Icons.arrow_back, color: Colors.black,), 
          label: Text('Back', style: Fonts.montserratFont(color: Colors.black, size: sizer(true, 20.0, context), fontWeight: FontWeight.w600),)),
        ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:sizer(true, 20.0, context)),
            child: Column(
              children: [

              
                SizedBox(
                  height: sizer(false, 32.0, context),
                ),
               SettingHeader(title: 'Profile Setting'),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.goalPageRoute);
                  },
                  child: SettingsCard(
                      tailing: true,
                    text: 'My Goals', 
                    onPressed: (){}, 
                    buttonText: 'Loose Wieght',
                    showSwitch: false,),
                ),
                  SizedBox(height: sizer(false, 7.0, context),),
                  SettingsCard(
                    tailing: true,
                text: 'My Budgets',
                onPressed: () {},
                buttonText: 'NGN 0.00/week',
                showSwitch: false,
              ),
               SizedBox(
                height: sizer(false, 32.0, context),
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
                onTap: (){
                   Navigator.of(context).pushNamed(Routes.languagePageRoute);
                },
                 child: SettingsCard(
                  tailing: true,
                  text: 'Language',
                  buttonText: 'English',
                             onPressed: (){
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


          
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'log out',
                  style: Fonts.montserratFont(
                      color: kWhiteColor,
                      size: sizer(true, 16.0, context),
                      fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              ),
              SizedBox(height: sizer(false, 57.0, context),)

              ],
            ),
          ),

        )),
    );
  
  }
}