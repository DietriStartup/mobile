import 'package:dietri/constants/fonts.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
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
              Positioned(
                top: 70,
                left: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    // backgroundColor: Colors.transparent,
                    child: Image.network(
                      auth.currentUser!.photoURL!,
                      height: 200,
                      fit: BoxFit.fill,
                      width: 200,
                    ),
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Text(
              'Profile Page',
              style: Fonts.robotoFont(
                  color: kBlack, size: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
