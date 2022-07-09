import 'package:dietri/components/button.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';

class FirstKYCScreen extends StatelessWidget {
  const FirstKYCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/amico.png',
          height: 300,
          width: 300,
        ),
        Text(
          'Welcome to Dietri!',
          style: Fonts.montserratFont(
              color: kPrimaryColor, size: 32, fontWeight: FontWeight.w400),
        ),
        Text(
          'Let\'s get you a more personalized meal \nplan.',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Fonts.montserratFont(
              color: kPrimaryColor, size: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
