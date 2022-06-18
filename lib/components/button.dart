import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/sizer.dart';

class FullButton extends StatefulWidget {
  final Function? buttonFunction;
  final String? buttonText;
  final bool isIcon;
  final bool isTextSmall;
  final String? iconAsset;
  final Color? buttonOnlineColor, onlineTextColor;

  const FullButton(
      {Key? key,
      required this.buttonFunction,
      this.buttonText,
      this.buttonOnlineColor,
      this.onlineTextColor,
      this.isIcon = false,
      this.isTextSmall = false,
      this.iconAsset})
      : super(key: key);

  @override
  _FullButtonState createState() => _FullButtonState();
}

class _FullButtonState extends State<FullButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: 
          widget.buttonFunction != null
                  ? () {
                      HapticFeedback.lightImpact();
                      widget.buttonFunction!();
                    }
                  : () {
                    },
          child: Container(
            height: sizer(false, 40, context),
            padding: const EdgeInsets.symmetric(vertical: 6.6),
            margin: const EdgeInsets.symmetric(vertical: 0.0),
            decoration: BoxDecoration(
                color: (widget.buttonOnlineColor ?? kPrimaryAccentColor)
                  ,
                borderRadius: BorderRadius.circular(10)),
            child:  Center(
                    child: Text(widget.buttonText ?? '',
                        style: TextStyle(
                            color: (widget.onlineTextColor ?? Colors.white),
                            fontSize: widget.isTextSmall
                                ? sizer(true, 11.5, context)
                                : sizer(true, 13, context),
                            fontWeight: FontWeight.w700))),
          ),
        ));
  }
}
