import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/constants/onboarding_screen_texts.dart';
import 'package:dietri/screens/onboarding/onboarding_screen_data.dart';
import 'package:dietri/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key, required this.model}) : super(key: key);
  final OnboardingViewModel model;

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Widget indicator(double width) {
    if (_currentPage == 0) {
      width = width * 0.2;
    } else if (_currentPage == 1) {
      width = width * 0.6;
    } else {
      width = width * 0.9;
    }
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 25.0,
      width: width,
      decoration: BoxDecoration(
        color: kPrimaryAccentColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: height * 0.7,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                controller: _pageController,
                children: const [
                  GetOnboardingPage(
                    imagePath: 'assets/images/onboarding1.png',
                    text1: firstPageHeader,
                    text2: firstPageSubHeader,
                  ),
                  GetOnboardingPage(
                    imagePath: 'assets/images/onboarding2.png',
                    text1: secondPageHeader,
                    text2: secondPageSubHeader,
                  ),
                  GetOnboardingPage(
                    imagePath: 'assets/images/onboarding3.png',
                    text1: thirdPageHeader,
                    text2: thirdPageSubHeader,
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 30,
                    width: width,
                    decoration: const BoxDecoration(
                        color: kGreyColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                Positioned(
                  left: 3,
                  top: 2.5,
                  child: indicator(width),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _currentPage == 2
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () async {
                      //TODO: PUSH TO SIGNUP SCREEN
                      await widget.model.completeOnboarding();
                      //Navigator.of(context).pushNamed('signIn');
                    },
                    child: Text(
                      'Let\'s Go!',
                      style: Fonts.montserratFont(
                          color: kBlack, size: 16, fontWeight: FontWeight.w400),
                    ),
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        'Skip',
                        style: Fonts.montserratFont(
                            color: kBlack,
                            size: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: Fonts.montserratFont(
                            color: kBlack,
                            size: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
