import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';

class MealPlanCard extends StatelessWidget {
  const MealPlanCard(
      {Key? key,
      required this.color,
      required this.color1,
      required this.foodType,
      required this.foodIngredients,
      required this.foodName})
      : super(key: key);
  final Color color;
  final Color color1;
  final FoodType foodType;
  final String foodIngredients;
  final String foodName;

  @override
  Widget build(BuildContext context) {
    getFoodTypeString(FoodType foodType) {
      switch (foodType) {
        case FoodType.breakfast:
          return 'Breakfast';
        case FoodType.lunch:
          return 'Lunch';
        case FoodType.dinner:
          return 'Dinner';
        default:
          return 'Snack';
      }
    }

    return Container(
      width: sizer(true, 450, context),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color1)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getFoodTypeString(foodType),
                  style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  foodName,
                  style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Ingredients',
                  style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 15,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      foodIngredients.toLowerCase().split(' ').map((word) {
                        String leftText = (word.length > 1)
                            ? word.substring(1, word.length)
                            : '';
                        return word[0].toUpperCase() + leftText;
                      }).join('\n'),
                      style: Fonts.montserratFont(
                          color: Colors.black,
                          size: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              showAlertDialog(context,
                                  title: 'Test',
                                  content: 'foods',
                                  defaultActionText: '');
                            },
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                minimumSize: const Size(20, 20)),
                            child: Text('Swap',
                                style: Fonts.montserratFont(
                                    color: Colors.white,
                                    size: 16,
                                    fontWeight: FontWeight.normal))),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                minimumSize: const Size(20, 20)),
                            child: Text('Recipe',
                                style: Fonts.montserratFont(
                                    color: Colors.white,
                                    size: 16,
                                    fontWeight: FontWeight.normal))),
                      ]),
                )
              ],
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    'assets/images/dietriBack.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '₦1300 - ₦1500',
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
