import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class GetOnboardingPage extends StatelessWidget {
  const GetOnboardingPage(
      {Key? key,
      required this.imagePath,
      required this.text1,
      required this.text2})
      : super(key: key);
  final String imagePath;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          imagePath,
          height: 270,
          width: 270,
        ),
        Text(
          text1,
          textAlign: TextAlign.center,
          style: Fonts.montserratFont(
              color: black, size: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: Fonts.montserratFont(
              color: black, size: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
