import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../services/auth.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.auth,
  }) : super(key: key);

  final AuthBase auth;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: title,
      leadingWidth: 80,
      elevation: 0,
      //Pass in user image and name
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 14),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.network(
                auth.currentUser!.photoURL!,
                height: 30,
              ),
            ),
            Text(
              'Hi, ${auth.currentUser!.displayName!.split(' ').first}',
              style: Fonts.montserratFont(
                  color: Colors.white,
                  size: 10,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    );
  }
}