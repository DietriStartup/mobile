import 'package:dietri/screens/authentication/auth_screen.dart';
import 'package:dietri/screens/home_page.dart';
import 'package:dietri/screens/onboarding/onboarding_screen.dart';
import 'package:dietri/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';

class OnboardingOrSignUp extends StatelessWidget {
  const OnboardingOrSignUp({Key? key, required this.onboardingViewModel})
      : super(key: key);
  final OnboardingViewModel onboardingViewModel;

  @override
  Widget build(BuildContext context) {
    return onboardingViewModel.isOnboardingComplete
        ? AuthScreen.create(context)
        : OnboardingScreens(
            model: onboardingViewModel,
          );
  }
}
