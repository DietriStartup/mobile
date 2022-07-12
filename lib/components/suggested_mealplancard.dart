import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:flutter/material.dart';

class SuggestedMealPlanCard extends StatelessWidget {
  const SuggestedMealPlanCard(
      {Key? key,
      required this.color,
      required this.color1,
      required this.foodIngredients,
      required this.foodName})
      : super(key: key);
  final Color color;
  final Color color1;

  final String foodIngredients;
  final String foodName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
                const SizedBox(height: 2),
                Text(
                  foodName,
                  style: Fonts.montserratFont(
                      color: Colors.black,
                      size: 16,
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
                      '$foodIngredients, test, test, test'
                          .toLowerCase()
                          .split(' ')
                          .map((word) {
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    '₦1300 - ₦1500',
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    size: 13,
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
                    width: 130,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
