import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dietri/constants/colors.dart';

import '../helper/sizer.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class MyBottomSheet extends StatefulWidget {
  List<Widget> content;
  final offset;
  final color;
  final paddingTop;
  MyBottomSheet(
      {Key? key,
      this.link,
      required this.content,
      this.offset,
      required this.color,
      required this.paddingTop})
      : super(key: key);

  final String? link;

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - widget.offset,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: widget.paddingTop,
          left: sizer(true, 39.0, context),
          bottom: sizer(true, 31.0, context),
          right: sizer(true, 39.0, context),
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(child: Column(children: widget.content)));
  }
}
