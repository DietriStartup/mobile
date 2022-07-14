import 'package:dietri/models/food.dart';
import 'package:dietri/models/saved_meal_model.dart';
import 'package:dietri/models/user_saved_meal.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ExploreViewModel {
  ExploreViewModel({
    required this.db,
    required this.auth,
  });
  final Database db;
  final AuthBase auth;

  Stream<List<SavedMeal>> savedMealsStream() {
    return Rx.combineLatest2(
        db.mealPlanStream(), db.userSavedMealStream(auth.currentUser!.uid),
        (List<Food> foods, List<UserSavedMeal?> userSavedMeals) {
      return foods.map((food) {
        final userSavedMeal = userSavedMeals.firstWhere(
            (userSavedMeal) => userSavedMeal?.foodId == food.foodId,
            orElse: () =>
                UserSavedMeal(foodId: food.foodId, isSavedMeal: null));
        return SavedMeal(
            food: food, isSavedMeal: userSavedMeal?.isSavedMeal ?? false);
      }).toList();
    });
  }
}
