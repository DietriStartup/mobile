import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReuseableFoodCard extends StatelessWidget {
  const ReuseableFoodCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182,
      //padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        color: kPrimaryAccentColor,
        child: Column(
          children: const [
            Image(
              image: AssetImage(
                'assets/images/pepper-soup.png',
              ),
            ),
            Text(
              'Pepper Soup',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kLightBlack,
                  fontSize: 15),
            ),
            Text(
              'Cost range',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kLightBlack,
                  fontSize: 15),
            ),
            Text(
              '₦1000-₦1300',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kLightBlack,
                  fontSize: 15),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
