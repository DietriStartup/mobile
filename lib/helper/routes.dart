import 'package:dietri/screens/authentication/signin_screen.dart';
import 'package:dietri/signup.dart';
import 'package:flutter/material.dart';

class Routes {
  static const signInRoute = 'signIn';
  static const signUpRoute = 'signUp';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInRoute:
        return MaterialPageRoute(builder: (context) => SigninScreen());
      case signUpRoute:
        return MaterialPageRoute(builder: (context) => Signup());

      default:
    }
  }
}
