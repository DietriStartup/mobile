import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    String _getGoalString(Goals? goal) {
      switch (goal) {
        case Goals.gainweight:
          return 'Gain weight';
        case Goals.looseweight:
          return 'Lose weight';
        case Goals.maintainweight:
          return 'Maintain weight';
        default:
          return '';
      }
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          Container(
            height: height * 0.5,
            width: width,
            decoration: const BoxDecoration(
                color: kPrimaryAccentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          _userPhotoCircle(context, width),
          Positioned(
            top: sizer(false, 250, context),
            left: width * 0.5 - (320 / 2),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.5 + 80),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                  ),
                ),
                _userDetailsWidget(_getGoalString),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _userDetailsWidget(String Function(Goals? goal) getGoalString) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 6), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userDetailsCard(userModel.name, 'Username'),
            const SizedBox(
              height: 10,
            ),
            _userDetailsCard('', 'Age'),
            const SizedBox(
              height: 10,
            ),
            _userDetailsCard(userModel.email, 'Email'),
            const SizedBox(
              height: 10,
            ),
            _userDetailsCard('${userModel.weight!} ${userModel.weightParam!}',
                'Current weight'),
            const SizedBox(
              height: 10,
            ),
            _userDetailsCard('', 'Height'),
            const SizedBox(
              height: 10,
            ),
            _userDetailsCard(getGoalString(userModel.goal), 'My Goals'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Positioned _userPhotoCircle(BuildContext context, double width) {
    return Positioned(
      top: sizer(false, 70, context),
      left: width * 0.5 - 80,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor, width: 1.5)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              // backgroundColor: Colors.transparent,
              child: Image.network(
                userModel.photoURL!,
                height: 160,
                fit: BoxFit.fill,
                width: 160,
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              color: kPrimaryColor,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Container _userDetailsCard(String text1, String text2) {
    return Container(
      height: 40,
      // width: 200,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: kPrimaryAccentColor)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Text(
              text1,
              maxLines: 2,
              style: Fonts.montserratFont(
                  color: kPrimaryColor, size: 15, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              text2,
              style: Fonts.montserratFont(
                  color: Colors.black38, size: 12, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
