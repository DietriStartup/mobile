import 'package:dietri/components/customappbar.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedMeals extends StatelessWidget {
  const SavedMeals({Key? key,required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: CustomAppBar(
              title: Image.asset(
                'assets/images/dietriLogo.png',
                height: 100,
                width: 110,
              ),
              userModel: userModel),
          preferredSize: Size.fromHeight(70)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            'Saved Meals',
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
