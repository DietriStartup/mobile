
import 'package:dietri/screens/settings/goal_settings.dart';
import 'package:dietri/screens/settings/language_settings_page.dart';
import 'package:dietri/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';


import '../screens/authentication/auth_screen.dart';

class Routes {
  static const String signInRoute = 'signIn';
  static const String signUpRoute = 'signUp';
  static const String settingPageRoute = 'settingPage';
  static const String languagePageRoute = 'languagePage';
  static const String goalPageRoute = 'goalSettingPage';

  //TODO:THIS SHOULD BE USED FOR THE IN-APP ROUTING,
  // NOT THE AUTH FLOW. SO WE DONT HAVE TO MANY SCREENS ON THE NAVIGATION STACK

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case signInRoute:
      //   return MaterialPageRoute(
      //       builder: (context) => AuthScreen.create(context));
      // case signUpRoute:
      //   return MaterialPageRoute(builder: (context) => Signup());
      case settingPageRoute:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case languagePageRoute:
        return MaterialPageRoute(builder: (context) => LanguageSettings());
      case goalPageRoute:
        return MaterialPageRoute(builder: (context) => GoalSettings());
      // case languagePageRoute:
      //   return  _getTransistionPageRoute(
      //     type: PageTransitionType.topToBottom,
      //     routeName: settings.name!,
      //     viewToShow: const LanguageSettings( ),
      //   );

       default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }


  // PageRoute _getPageRoute(
  //     {required String routeName, required Widget viewToShow}) {
  //   return MaterialPageRoute(
  //       settings: RouteSettings(
  //         name: routeName,
  //       ),
  //       builder: (_) => viewToShow);
  // }

  // PageRoute _getTransistionPageRoute({
  //   required String routeName,
  //   required Widget viewToShow,
  //   PageTransitionType type = PageTransitionType.bottomToTop,
  // }) {
  //   return PageTransition(
  //       settings: RouteSettings(
  //         name: routeName,
  //       ),
  //       type: type,
  //       child:viewToShow);
  // }
}
