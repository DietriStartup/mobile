import 'package:flutter/material.dart';
import 'package:dietri/constants/onboarding_screen_texts.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/helper/sizer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/images/chef.png'),
            ),
            const CircularProgressIndicator(
              backgroundColor: kLightGrey,
              color: kPrimaryColor,
            ),
            Text(
              kycFinalText,
              style: Fonts.montserratFont(
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
