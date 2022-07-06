import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  static const onboardingCompleteKey = 'onboardingComplete';
  final SharedPreferences sharedPreferences;

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() {
    return sharedPreferences.getBool(onboardingCompleteKey) ?? false;
  }
}
