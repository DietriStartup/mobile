import 'package:dietri/components/settings/language_tiles.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/enum/language.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';



class LanguageSettings extends StatefulWidget {
  const LanguageSettings({ Key? key }) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: 'English',
              lang: Language.English,
            ),
              SizedBox(
              height: sizer(false, 7.0, context),
            ),
            LanguageTiles(
              text: 'Yoruba',
              lang: Language.Yoruba,
            ),
              SizedBox(
              height: sizer(false, 7.0, context),
            ),
            LanguageTiles(
              text: 'Hausa',
              lang: Language.Hausa,
            ),
            SizedBox(
              height: sizer(false, 7.0, context),
            ),
             LanguageTiles(
              text: 'Igbo',
              lang: Language.Igbo,
            ),
            SizedBox(
              height: sizer(false, 7.0, context),
            ),
             LanguageTiles(
              text: 'Swahili',
              lang: Language.Swahili,
            ),
            SizedBox(
              height: sizer(false, 7.0, context),
            ),
             LanguageTiles(
              text: 'French',
              lang: Language.French,
            ),
           
          
          
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Save',
            //     style: Fonts.montserratFont(
            //         color: kWhiteColor,
            //         size: sizer(true, 16.0, context),
            //         fontWeight: FontWeight.w400),
            //   ),
            //   style: ElevatedButton.styleFrom(primary: kPrimaryColor),
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