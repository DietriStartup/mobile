import 'dart:io';

import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(BuildContext context,
    {required String title,
    required String? content,
    required String defaultActionText,
    String? cancelActionText}) {
  if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                content ?? 'Error Message',
                style: Fonts.montserratFont(
                    color: Colors.black,
                    size: 14,
                    fontWeight: FontWeight.normal),
              ),
              title: Text(
                title,
                style: Fonts.montserratFont(
                    color: Colors.black, size: 16, fontWeight: FontWeight.bold),
              ),
              actions: [
                if (cancelActionText != null)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      cancelActionText,
                      style: Fonts.montserratFont(
                          color: Colors.black,
                          size: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    defaultActionText,
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: Text(
                content ?? 'Error Message',
                style: Fonts.montserratFont(
                    color: Colors.black,
                    size: 14,
                    fontWeight: FontWeight.normal),
              ),
              title: Text(
                title,
                style: Fonts.montserratFont(
                    color: Colors.black, size: 16, fontWeight: FontWeight.bold),
              ),
              actions: [
                if (cancelActionText != null)
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      cancelActionText,
                      style: Fonts.montserratFont(
                          color: Colors.black,
                          size: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    defaultActionText,
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  }
}
