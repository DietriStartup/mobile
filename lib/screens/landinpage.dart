
import 'package:dietri/screens/kyc/kyc_widget.dart';
import 'package:dietri/screens/mainscreens/kycorhomepage.dart';
import 'package:dietri/view_models/onboarding_view_model.dart';
import 'package:dietri/screens/onboarding_signin.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/shared_prefereces_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final sP = context.read<SharedPreferencesService>();
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;

            if (user == null) {
             return OnboardingOrSignUp.create(context, sP);
            }

            return  const KYCOrHomePage();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
