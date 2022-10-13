import 'package:dietri/components/button.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/sizer.dart';

class EmailNotVerified extends StatelessWidget {
  const EmailNotVerified({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final db = Provider.of<Database>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verfication link has been sent to your email address',
              style: Fonts.montserratFont(
                  color: Colors.black, size: 24, fontWeight: FontWeight.w500),
            ),
            Image.asset('assets/images/yellow_tick.png'),
            FullButton(
              buttonFunction: () async {
                User? user = auth.currentUser;
                if (user != null) {
                  await user.reload();
                  db.createUserinDatabase(user);
                }
              },
              height: sizer(true, 50, context),
              buttonText: 'OK',
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
