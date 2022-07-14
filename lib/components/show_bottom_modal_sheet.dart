import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class ShowModalContent extends StatelessWidget {
  const ShowModalContent(
      {Key? key,
      required this.foodName,
      required this.foodIngredients,
      required this.procedure,
      required this.height})
      : super(key: key);
  final String foodName, foodIngredients;
  final List procedure;
  final double height;
  @override
  Widget build(BuildContext context) {
    List<Widget> _getfoodProcedure(List procedure) {
      var textWidgets = <Widget>[];
      for (var i = 0; i < procedure.length; i++) {
        textWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step ${i + 1}:',
              style: Fonts.montserratFont(
                  color: Colors.black, size: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${procedure[i]}',
              style: Fonts.montserratFont(
                  color: Colors.black, size: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
      }
      return textWidgets;
    }

    return DraggableScrollableSheet(
        initialChildSize: 0.55,
        maxChildSize: 1,
        minChildSize: 0.35,
        builder: (_, controller) {
          return SingleChildScrollView(
            controller: controller,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: kPrimaryAccentColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Container(
                              height: 7,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Text(
                            foodName,
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/dietriBack.png',
                                  height: 200,
                                  width: 345,
                                  fit: BoxFit.fitWidth,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Ingredients',
                              style: Fonts.montserratFont(
                                  color: Colors.black,
                                  size: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 2,
                              color: kPrimaryAccentColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              foodIngredients
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
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Procedures',
                              textAlign: TextAlign.center,
                              style: Fonts.montserratFont(
                                  color: Colors.black,
                                  size: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 2,
                              color: kPrimaryAccentColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ..._getfoodProcedure(procedure),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
