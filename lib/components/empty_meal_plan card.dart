import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';

class EmptyMealPlanCard extends StatelessWidget {
  const EmptyMealPlanCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizer(false, 230, context),
      width: sizer(true, 470, context),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: kPrimaryAccentColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No meal plan available yet..',
             style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            Text(
              'got to the explore page \nto add some meals',
             style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 14,
                      fontWeight: FontWeight.normal),
            ),
          ]
        ),),
    );
  }
}