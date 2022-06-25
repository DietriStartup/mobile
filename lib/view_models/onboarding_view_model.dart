import 'package:dietri/services/shared_prefereces_service.dart';
import 'package:flutter/cupertino.dart';

//TODO: MAKE THIS VIEWMODEL CONTROL THE ONBOARDING VIEW

class OnboardingViewModel with ChangeNotifier  {
  OnboardingViewModel({required this.sharedPreferencesService,required this.value});

  final SharedPreferencesService sharedPreferencesService;
  bool value = false;


  _setValue(bool _value){
    value = _value;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await sharedPreferencesService.setOnboardingComplete();
   _setValue(true);
  }

  bool get isOnboardingComplete => value;
}
