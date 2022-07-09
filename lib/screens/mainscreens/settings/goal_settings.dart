import 'package:dietri/components/settings/language_tiles.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/enum/language.dart';
import 'package:flutter/material.dart';

import '../../../constants/fonts.dart';
import '../../../helper/sizer.dart';

class GoalSettings extends StatefulWidget {
  const GoalSettings({Key? key}) : super(key: key);

  @override
  State<GoalSettings> createState() => _GoalSettingsState();
}

class _GoalSettingsState extends State<GoalSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextButton.icon(
            onPressed: (() => Navigator.of(context).pop()),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            label: Text(
              'Back',
              style: Fonts.montserratFont(
                  color: Colors.black,
                  size: sizer(true, 20.0, context),
                  fontWeight: FontWeight.w600),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 20.0, context)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: sizer(false, 32.0, context),
              ),
              LanguageTiles(
                text: 'Gain Weight',
                lang: Language.English,
              ),
              SizedBox(
                height: sizer(false, 7.0, context),
              ),
              LanguageTiles(
                text: 'Loose Weight',
                lang: Language.Yoruba,
              ),
              SizedBox(
                height: sizer(false, 7.0, context),
              ),
              LanguageTiles(
                text: 'Maintain Weight',
                lang: Language.Hausa,
              ),
              SizedBox(
                height: sizer(false, 7.0, context),
              ),
              // LanguageTiles(
              //   isOthers: true,
              //   text: 'others',
              //   lang: Language.Igbo,
              //   // height: 70, 
              // ),
            
          

              SizedBox(
                height: sizer(false, 87.0, context),
              ),

              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: Fonts.montserratFont(
                      color: kWhiteColor,
                      size: sizer(true, 16.0, context),
                      fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
