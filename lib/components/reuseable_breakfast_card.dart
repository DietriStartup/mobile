import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReuseableBreakfastCard extends StatelessWidget {
  const ReuseableBreakfastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: kPrimaryAccentColor,
          elevation: 10,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Breakfast',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kLightBlack,
                            fontSize: 15),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et nisl hendrerit, aliquet mi sed, scelerisque tortor. Aliquam eu',
                        style: TextStyle(fontSize: 14, color: kLightBlack),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text(
                            'See More',
                            style: TextStyle(color: kLightBlack),
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/double-chevron-right.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    
                      Image(
                        image: AssetImage(
                          'assets/images/Breakfast.png',
                        ),
                      ),
                    
                    Padding(
                      padding: EdgeInsets.only(
                        right: 8,
                        left: 8,
                      ),
                      child: Text(
                        'Oat and Berries',
                        style: TextStyle(fontWeight: FontWeight.bold, color: kLightBlack),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cost range: ₦1200-₦2000',
                        style: TextStyle(color: kLightBlack),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
