import 'package:dietri/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      theme: ThemeData(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.red,
          home: Signup(),
        ),
=======
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.red,
>>>>>>> Stashed changes
      ),
    );
  }
}
