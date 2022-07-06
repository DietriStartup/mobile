import 'dart:io';

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
              content: Text(content?? 'Error Message'),
              title: Text(title),
              actions: [
                if (cancelActionText != null)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(cancelActionText),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(defaultActionText),
                )
              ],
            ));
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: Text(content ?? 'Error Message'),
              title: Text(title),
              actions: [
                if (cancelActionText != null)
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(cancelActionText),
                  ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(defaultActionText),
                )
              ],
            ));
  }
}
