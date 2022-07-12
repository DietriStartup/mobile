import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class EmptyMealPlanCard extends StatelessWidget {
  const EmptyMealPlanCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: kPrimaryAccentColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
          children: [
            Text(
              'No meal plan available yet..',
             style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
            ),
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