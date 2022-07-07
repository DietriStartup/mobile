
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../constants/colors.dart';

class ReusableQuoteCard extends StatelessWidget {
  const ReusableQuoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: kPrimaryAccentColor,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Quote of the Day', style: TextStyle(color: kLightBlack, fontSize: 15, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('We provide jobs in accounting, cfo jobs, finance manager jobs, investment jobs and more.', style: TextStyle(color: kLightBlack),),
            )
          ],
        ),
      ),
    );
  }
}
