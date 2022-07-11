import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(
      {Key? key,
      required this.addNewMeal,
      required this.saveMeal,
      required this.isSavedMeal,
      required this.showOptions,
      required this.foodName,
      required this.foodURL})
      : super(key: key);
  final VoidCallback addNewMeal, saveMeal, showOptions;
  final bool isSavedMeal;
  final String foodName;
  final String foodURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showOptions,
      child: Container(
        height: 100,
        width: 180,
        decoration: BoxDecoration(
            color: kPrimaryAccentColor, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              foodURL,
              fit: BoxFit.fitHeight,
              height: 100,
              width: 140,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodName,
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 14,
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
