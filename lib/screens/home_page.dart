import 'package:dietri/components/reueable_food_card.dart';
import 'package:dietri/components/reuseable_quote_card.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/reuseable_breakfast_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBase>();
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableQuoteCard(),
          SizedBox(height: 20,),
          ReuseableBreakfastCard(),
          SizedBox(height: 20,),
          ReuseableFoodCard(),
          const Center(
            child: Text('youre welcome'),
          ),
          ElevatedButton(
              onPressed: () {
                auth.signOut();
              },
              child: const Text('signOut'))
        ],
      )),
    );
  }
}
