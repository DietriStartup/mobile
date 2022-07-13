import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(
      {Key? key,
      required this.addNewMeal,
      required this.saveMeal,
      required this.isSavedMeal,
      required this.showMealPlan,
      required this.foodName,
      required this.foodURL})
      : super(key: key);
  final VoidCallback addNewMeal, saveMeal, showMealPlan;
  final bool isSavedMeal;
  final String foodName;
  final String foodURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showMealPlan,
      child: Container(
        height: 100,
        width: 180,
        decoration: BoxDecoration(
            color: kPrimaryAccentColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kPrimaryColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/dietriBack.png',
              fit: BoxFit.fitHeight,
              height: 100,
              width: 140,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodName,
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 13,
                        fontWeight: FontWeight.normal),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: addNewMeal, child: Icon(Icons.add)),
                      SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                          onTap: saveMeal,
                          child: Icon(isSavedMeal
                              ? Icons.bookmark
                              : Icons.bookmark_outline))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
