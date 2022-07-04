
import 'package:flutter/material.dart';

import '../../constants/fonts.dart';
import '../../helper/sizer.dart';

class SettingHeader extends StatelessWidget {
  final String title;
  const SettingHeader({ 
    Key? key,
    required this.title 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Column(
      children:[ Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text( title,
                        style: Fonts.montserratFont(
                            color: Colors.black,
                            size: sizer(true, 16.0, context),
                            fontWeight: FontWeight.w600))
                  ],
                ),
              SizedBox(height: sizer(false, 5.0, context),)
      ]
    );
  }
}