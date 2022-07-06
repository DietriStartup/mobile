import 'package:dietri/helper/permissions.dart';
import 'package:dietri/screens/authentication/auth_screen.dart';
import 'package:dietri/screens/home_page.dart';
import 'package:dietri/screens/landinpage.dart';
import 'package:dietri/screens/onboarding/onboarding_screen.dart';
import 'package:dietri/helper/routes.dart';
import 'package:dietri/screens/settings/settings_page.dart';
import 'package:dietri/view_models/onboarding_view_model.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/shared_prefereces_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PermissionHandler.getStoragePermission();
 sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

getonBoardingStatus (){

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthBase>(
            create: (_) => Auth(),
          ),
          Provider<SharedPreferencesService>(
            create: (_) => SharedPreferencesService(sharedPreferences!)            
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            onGenerateRoute: Routes.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(),
            home: const LandingPage(),
          );
        });
  }
}
