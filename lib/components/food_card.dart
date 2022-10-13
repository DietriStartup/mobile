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
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          color: kPrimaryAccentColor,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: kPrimaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.asset(
                'assets/images/dietriBack.png',
                height: 110,
                width: 140,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      foodName,
                      style: Fonts.montserratFont(
                          color: Colors.black,
                          size: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: addNewMeal,
                          child: const Icon(
                            Icons.add,
                            size: 25,
                          )),
                      const SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                          onTap: saveMeal,
                          child: Icon(
                            isSavedMeal
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: 25,
                            color: Colors.black,
                          ))
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
