import 'package:dietri/screens/authentication/auth_screen.dart';
import 'package:dietri/screens/onboarding/onboarding_screen.dart';
import 'package:dietri/services/shared_prefereces_service.dart';
import 'package:dietri/view_models/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingOrSignUp extends StatelessWidget {
  const OnboardingOrSignUp({Key? key, required this.onboardingViewModel})
      : super(key: key);
  final OnboardingViewModel onboardingViewModel;

  static Widget create(BuildContext context, SharedPreferencesService sP) {
    return ChangeNotifierProvider<OnboardingViewModel>(
        create: (_) => OnboardingViewModel(
            sharedPreferencesService: sP, value: sP.isOnboardingComplete()),
        builder: (context, child) {
          return Consumer<OnboardingViewModel>(builder: (__, value, _) {
            return OnboardingOrSignUp(onboardingViewModel: value);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return onboardingViewModel.isOnboardingComplete
        ? AuthScreen.create(context)
        : OnboardingScreens(
            model: onboardingViewModel,
          );
  }
}
