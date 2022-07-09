import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';



class ThirdKYCScreen extends StatelessWidget {
  const ThirdKYCScreen({Key? key,required this.goals,required this.onPressed,required this.onPressed1,required this.onPressed2}) : super(key: key);
  final Goals? goals;
  final VoidCallback onPressed, onPressed1, onPressed2;
 
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is your current goal?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          OutlinedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  primary: goals == Goals.gainweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Gain weight',
                style: Fonts.montserratFont(
                    color: goals == Goals.gainweight
                        ? Colors.white
                        : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: onPressed1,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  primary: goals == Goals.maintainweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Maintain Weight',
                style: Fonts.montserratFont(
                    color: goals == Goals.maintainweight
                        ? Colors.white
                        : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: onPressed2,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  primary: goals == Goals.looseweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Lose weight',
                style: Fonts.montserratFont(
                    color: goals == Goals.looseweight
                        ? Colors.white
                        : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
