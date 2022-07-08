import 'package:flutter/material.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/constants/colors.dart';

class SecondOnboard extends StatelessWidget {
  const SecondOnboard(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.isBackIcon,
      required this.widgets})
      : super(key: key);
  final String text1;
  final String text2;
  final bool isBackIcon;
  final Widget widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: isBackIcon
              ? const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_back_outlined,
                  ),
                )
              : null,
        ),
        Text(
          text1,
          textAlign: TextAlign.center,
          style: Fonts.montserratFont(
            color: kBlack,
            size: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: Fonts.montserratFont(
            color: kBlack,
            size: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        widgets,
      ],
    );
  }
}
