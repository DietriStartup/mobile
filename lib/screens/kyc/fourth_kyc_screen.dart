import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:flutter/material.dart';



class FourthKYCScreen extends StatelessWidget {
  const FourthKYCScreen({Key? key, required this.editingController, required this.onPressed,required this.onPressed1,required this.onPressed2,required this.weight}) : super(key: key);
  final TextEditingController editingController;
  final VoidCallback onPressed, onPressed1, onPressed2;
  final Weight weight;
 



  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'What is your current weight?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: TextField(
              controller: editingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Fonts.montserratFont(
                  color: kPrimaryColor, size: 32, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  enabledBorder:  const OutlineInputBorder(
                  
                    borderSide:  BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  focusedBorder:const OutlineInputBorder(
                    
                    borderSide:  BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                   
                    borderSide:  BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    UserUtils.getWeightString(weight),
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onPressed,
                child: Text(
                  'st',
                  style: Fonts.montserratFont(
                      color: kPrimaryColor,
                      size: 16,
                      fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                    primary: weight == Weight.st
                        ? kPrimaryAccentColor
                        : Colors.white),
              ),
              TextButton(
                  onPressed: onPressed1,
                  style: ElevatedButton.styleFrom(
                      primary: weight == Weight.lb
                          ? kPrimaryAccentColor
                          : Colors.white),
                  child: Text(
                    'lb',
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  )),
              TextButton(
                  onPressed: onPressed2,
                  style: ElevatedButton.styleFrom(
                      primary: weight == Weight.kg
                          ? kPrimaryAccentColor
                          : Colors.white),
                  child: Text(
                    'kg',
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
