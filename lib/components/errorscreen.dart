import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title != null ? title! : 'Something went wrong...',
            style: Fonts.montserratFont(
                color: kPrimaryColor, size: 32, fontWeight: FontWeight.normal),
          ),
          // const Center(
          //   child: CircularProgressIndicator(),
          // ),
        ],
      ),
    );
  }
}
