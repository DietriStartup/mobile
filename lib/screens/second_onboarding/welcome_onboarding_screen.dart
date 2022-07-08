import 'package:dietri/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/onboarding_screen_texts.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/second_onboarding/second_onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            8.0,
            8.0,
            8.0,
            20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_back_outlined,
                  ),
                ),
              ),
              const Image(
                image: AssetImage('assets/images/amico.png'),
              ),
              Text(
                kycText,
                style: Fonts.montserratFont(
                  color: kPrimaryColor,
                  size: 32,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                kycSubHead,
                style: Fonts.montserratFont(
                  color: kWhiteColor,
                  size: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              FullButton(
                buttonFunction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondOnboarding()));
                },
                height: 23,
                width: 30,
                buttonOnlineColor: const Color.fromARGB(255, 97, 34, 12),
                onlineTextColor: kWhiteColor,
                buttonText: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
