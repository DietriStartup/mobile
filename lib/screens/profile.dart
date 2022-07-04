import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Profile Page', style: Fonts.robotoFont(color: kBlack, size: 24, fontWeight: FontWeight.bold),),
      ),
    );
  }
}