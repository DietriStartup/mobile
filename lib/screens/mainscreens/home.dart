import 'package:dietri/components/mealplan_card.dart';
import 'package:dietri/components/quoteoftheday_card.dart';
import 'package:dietri/components/suggested_mealplancard.dart';
import 'package:dietri/components/swiper_view_item_builder.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:card_swiper/card_swiper.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: kPrimaryColor, width: 1.5)),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: Image.network(
                              userModel.photoURL!.isEmpty ||
                                      userModel.photoURL == null
                                  ? kDefaultProfilePhoto
                                  : userModel.photoURL!,
                              height: 80,
                              fit: BoxFit.fill,
                              width: 80,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Hi, ${userModel.name.split(' ').first}',
                            textAlign: TextAlign.right,
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 70.0, right: 22),
                          child: Icon(
                            Icons.notifications,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
                  child: QuoteCard(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Today\'s Meals',
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Center(
                  child: SizedBox(
                    height: sizer(false, 250, context),
                    width: sizer(true, 470, context),
                    child: StreamBuilder<List<Food>>(
                      stream: db.userMealPlanStream(auth.currentUser!.uid),
                      builder: (context, snapshot) {
                        return SwiperViewItemsBuilder<Food>(
                            snapshot: snapshot,
                            itemBuilder: (context, food) => MealPlanCard(
                                onPressed: () {
                                  UserUtils.dietriModalBSheet(
                                      context, food, height);
                                },
                                color: kWhiteColor,
                                color1: kPrimaryColor,
                                foodType:
                                    UserUtils.intToFoodType(food.foodType)!,
                                foodIngredients: food.foodIngredients,
                                foodName: food.foodName),
                            isReverse: false,
                            layout: SwiperLayout.TINDER,
                            autoPlay: false,
                            viewPortFraction: 1,
                            itemHeight: 250,
                            itemWidth: 450);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: Text(
                    'Suggested Meals',
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Center(
                  child: SizedBox(
                    height: sizer(false, 230, context),
                    width: sizer(true, 470, context),
                    child: StreamBuilder<List<Food>>(
                      stream: db.mealPlanStream(),
                      builder: (context, snapshot) {
                        return SwiperViewItemsBuilder<Food>(
                            snapshot: snapshot,
                            itemBuilder: (context, food) =>
                                SuggestedMealPlanCard(
                                    foodIngredients: food.foodIngredients,
                                    color: kPrimaryAccentColor,
                                    color1: kPrimaryColor,
                                    onPressed: () {
                                      UserUtils.dietriModalBSheet(
                                          context, food, height);
                                    },
                                    foodName: food.foodName),
                            isReverse: false,
                            autoPlay: true,
                            pagination: const SwiperPagination(
                                margin: EdgeInsets.only(top: 10, bottom: 3)),
                            viewPortFraction: 0.9,
                            scale: 0.6,
                            layout: SwiperLayout.DEFAULT,
                            itemHeight: 250,
                            itemWidth: 300);
                      },
                    ),
                  ),
                ),

                //ReuseableFoodCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
