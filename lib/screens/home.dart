import 'package:dietri/constants/fonts.dart';
import 'package:dietri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/reueable_food_card.dart';
import '../components/reuseable_breakfast_card.dart';
import '../components/reuseable_quote_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  get kBlack => null;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      
        //mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ReusableQuoteCard(),
          SizedBox(height: 20,),
          ReuseableBreakfastCard(),
          SizedBox(height: 20,),
          ReuseableFoodCard(),
          
        ],
      ),
    );
  }
}
