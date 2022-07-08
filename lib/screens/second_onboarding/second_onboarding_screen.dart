import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dietri/second_onboarding/second_onboarding_data.dart';
import 'package:dietri/second_onboarding/loading_screen.dart';
import 'package:dietri/constants/onboarding_screen_texts.dart';
import 'package:dietri/components/button.dart';
import 'package:dietri/constants/fonts.dart';

class SecondOnboarding extends StatefulWidget {
  SecondOnboarding({Key? key}) : super(key: key);

  @override
  State<SecondOnboarding> createState() => _SecondOnboardingState();
}

class _SecondOnboardingState extends State<SecondOnboarding> {
  late final PageController _pageController;

  Widget secondPage = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        child: Text(
          'Male',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        child: Text(
          'Female',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        child: Text(
          'Others',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
  Widget thirdPage = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      OutlinedButton.icon(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        icon: const ImageIcon(
          AssetImage('assets/images/Stairs.png'),
        ),
        label: Text(
          'Male',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      OutlinedButton.icon(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        icon: const ImageIcon(
          AssetImage('assets/images/Scales.png'),
        ),
        label: Text(
          'Male',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      OutlinedButton.icon(
        onPressed: null,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: kPrimaryColor,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        icon: const ImageIcon(
          AssetImage('assets/images/Vector.png'),
        ),
        label: Text(
          'Male',
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
  Widget fourthPage = Column(
    children: [
      Row(
        children: [
          TextButton(
            onPressed: null,
            child: Text(
              'st',
              style: Fonts.montserratFont(
                  color: kBlack, size: 20, fontWeight: FontWeight.normal),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              'lbs',
              style: Fonts.montserratFont(
                  color: kBlack, size: 20, fontWeight: FontWeight.normal),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text(
              'kg',
              style: Fonts.montserratFont(
                  color: kBlack, size: 20, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PageView(
                controller: _pageController,
                children: [
                  SecondOnboard(
                      text1: kycTextTwoHead,
                      text2: kycTextTwoSubHead,
                      isBackIcon: false,
                      widgets: secondPage),
                  SecondOnboard(
                      text1: kycTextThreeHead,
                      text2: kycTextThreeSubHead,
                      isBackIcon: true,
                      widgets: thirdPage),
                  SecondOnboard(
                      text1: kycTextFourHead,
                      text2: kycTextFourSubHead,
                      isBackIcon: true,
                      widgets: fourthPage),
                ],
              ),
              Text(
                kycTextSubHead,
                style: Fonts.montserratFont(
                  color: kDarkBlue,
                  size: 12,
                  fontWeight: FontWeight.w200,
                ),
              ),
              FullButton(
                buttonFunction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingScreen()));
                },
                height: 30,
                width: 20,
                buttonText: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
