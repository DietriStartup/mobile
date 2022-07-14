import 'package:dietri/components/customappbar.dart';
import 'package:dietri/components/food_card.dart';
import 'package:dietri/components/grid_view_item_builder.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/saved_meal_model.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/models/user_saved_meal.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/explore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedMealsPage extends StatelessWidget {
  const SavedMealsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<ExploreViewModel>(
      create: (_) => ExploreViewModel(db: db, auth: auth),
      child: const SavedMealsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExploreViewModel>(context, listen: false);
    final db = Provider.of<Database>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Saved Meals',
                style: Fonts.montserratFont(
                    color: Colors.black, size: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 5,
                child: StreamBuilder<List<SavedMeal?>>(
                  stream: vm.savedMealsStream(),
                  builder: (context, snapshot) {
                    return GridViewItemsBuilder<SavedMeal>(
                        snapshot: snapshot,
                        crossAxisCount: 2,
                        itemBuilder: (context, savedMeal) =>
                            savedMeal.isSavedMeal == false
                                ? Container()
                                : FoodCard(
                                    addNewMeal: () {},
                                    saveMeal: () {
                                      _toggleSavedMeal(
                                          context,
                                          savedMeal.isSavedMeal ?? false,
                                          savedMeal.food.foodId);
                                    },
                                    isSavedMeal: savedMeal.isSavedMeal ?? false,
                                    showMealPlan: () {
                                      UserUtils.dietriModalBSheet(
                                          context,
                                          savedMeal.food,
                                          MediaQuery.of(context).size.height);
                                    },
                                    foodName: savedMeal.food.foodName,
                                    foodURL: savedMeal.food.foodURL),
                        isReverse: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSavedMeal(
      BuildContext context, bool isSavedMeal, String foodId) async {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await db.setUserSavedMeal(
          UserSavedMeal(foodId: foodId, isSavedMeal: !isSavedMeal),
          auth.currentUser!.uid);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
