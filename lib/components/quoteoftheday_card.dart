import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizer(false, 90, context),
      width: sizer(true, 400, context),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quote of the Day',
              style: Fonts.montserratFont(
                  color: kWhiteColor, size: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sapa nice one',
              style: Fonts.montserratFont(
                  color: kWhiteColor, size: 14, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
