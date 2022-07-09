import 'package:dietri/constants/colors.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/screens/mainscreens/home_page.dart';
import 'package:dietri/screens/kyc/kyc_widget.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KYCOrHomePage extends StatelessWidget {
  const KYCOrHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<UserModel?>(
      stream: db.userStream(auth.currentUser!.uid),
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final userModel = snapshot.data;
          if (userModel!.isKYCComplete == true) {
            return const HomePage();
          }
          return KYCScreens.create(context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
           return  Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/bro.png'),
                const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor,),
                ),
              ],
            ),
          ); 
        }
         return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ); 
    }));
  }
}