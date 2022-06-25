
import 'package:flutter/material.dart';

class Routes {
  static const signInRoute = 'signIn';
  static const signUpRoute = 'signUp';

  //TODO:THIS SHOULD BE USED FOR THE IN-APP ROUTING,
  // NOT THE AUTH FLOW. SO WE DONT HAVE TO MANY SCREENS ON THE NAVIGATION STACK

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case signInRoute:
      //   return MaterialPageRoute(
      //       builder: (context) => AuthScreen.create(context));
      // case signUpRoute:
      //   return MaterialPageRoute(builder: (context) => Signup());

      default:
    }
  }
}
