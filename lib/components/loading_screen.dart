import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/bro.png',
            height: 350,
            width: 350,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              backgroundColor: kPrimaryAccentColor,
            ),
          ),
        ],
      ), 
    );
  }
}
