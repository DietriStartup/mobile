import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';



class SecondKYCScreen extends StatelessWidget {
  const SecondKYCScreen({Key? key,required this.gender,required this.onPressed,required this.onPressed1,required this.onPressed2}) : super(key: key);
  final Gender? gender;
  final VoidCallback onPressed, onPressed1, onPressed2;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is your gender?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          OutlinedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary:
                      gender == Gender.male ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Male',
                style: Fonts.montserratFont(
                    color:
                        gender == Gender.male ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: onPressed1,
              style: ElevatedButton.styleFrom(
                  primary:
                      gender == Gender.female ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Female',
                style: Fonts.montserratFont(
                    color:
                        gender == Gender.female ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: onPressed2,
              style: ElevatedButton.styleFrom(
                  primary:
                      gender == Gender.others ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Others',
                style: Fonts.montserratFont(
                    color:
                        gender == Gender.others ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}
