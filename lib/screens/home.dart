import 'package:dietri/constants/fonts.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  get kBlack => null;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome ${auth.currentUser!.displayName}',
            style: Fonts.robotoFont(
                color: Colors.black, size: 15, fontWeight: FontWeight.w400),
          ),
          Center(
            child: Text(
              'Home Page ',
              style: Fonts.robotoFont(
                  color: Colors.black, size: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
