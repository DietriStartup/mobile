import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:dietri/helper/enums.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/models/saved_meal_model.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';

class ExploreViewModel with ChangeNotifier {
  ExploreViewModel({
    required this.db,
    required this.auth,
  });
  final Database db;
  final AuthBase auth;
  List<SavedMeal> foodList = [];
  List<SavedMeal> foodSuggestion = [];
  String query = "";
  String filterQuery = '';
  StreamSubscription? _streamSubscription;
  FoodType? foodType;

  Stream<List<SavedMeal>> exploreMealsStream() {
    return Rx.combineLatest2(
        db.mealPlanStream(), db.userSavedMealStream(auth.currentUser!.uid),
        (List<Food> foods, List<Food?> userSavedMeals) {
      return foods.map((food) {
        final userSavedMeal = userSavedMeals.firstWhere(
            (userSavedMeal) => userSavedMeal?.foodId == food.foodId,
            orElse: () => Food(
                foodId: food.foodId,
                isSavedMeal: null,
                foodIngredients: food.foodIngredients,
                foodName: food.foodName,
                foodType: food.foodType,
                foodURL: food.foodIngredients,
                procedure: food.procedure));
        return SavedMeal(
            food: food, isSavedMeal: userSavedMeal?.isSavedMeal ?? false);
      }).toList();
    });
  }

  void closeStream() => _streamSubscription?.cancel();

  void updateFoodList() {
    _streamSubscription = exploreMealsStream().listen((event) {
      updateWith(foodList: event);
    });
  }

  // updateFoodList(List<SavedMeal> foodList) => updateWith(foodList: foodList);
  updateQuery(String query) => updateWith(query: query);

  updateFilterQuery(String filterQuery) => updateWith(filterQuery: filterQuery);

  updateFoodType(FoodType? foodType) => updateWith(foodType: foodType);

  Future<void> toggleSavedMeal(
    Food food,
    bool isSavedMeal,
  ) async {
    try {
      await db.setUserSavedMeal(
          Food(
              foodName: food.foodName,
              foodURL: food.foodURL,
              foodId: food.foodId,
              foodIngredients: food.foodIngredients,
              foodType: food.foodType,
              procedure: food.procedure,
              isSavedMeal: !isSavedMeal),
          auth.currentUser!.uid);
      if (isSavedMeal == true) {
        await db.deleteSavedMeal(food.foodId, auth.currentUser!.uid);
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addNewMeal(
      Food food, String foodTypeString, FoodType foodType) async {
    try {
      await db.addNewMealPlan(
          food, auth.currentUser!.uid, foodTypeString, foodType);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void getFoodSearchResults() {
    if (query.isNotEmpty && filterQuery.isNotEmpty) {
      foodSuggestion = foodList
          .where((element) {
            String _getFoodType = UserUtils.getFoodTypeString(
                    UserUtils.intToFoodType(element.food.foodType)!)
                .toLowerCase();
            String _filterQuery = filterQuery.toLowerCase();
            bool matchesFilter = _getFoodType.contains(_filterQuery);
            return matchesFilter;
          })
          .toList()
          .where((element) {
            String _getFoodName = element.food.foodName.toLowerCase();
            String _query = query.toLowerCase();
            bool matches = _getFoodName.contains(_query);
            return matches;
          })
          .toList();
    } else if (filterQuery.isNotEmpty) {
      foodSuggestion = foodList.where((element) {
        String _getFoodType = UserUtils.getFoodTypeString(
                UserUtils.intToFoodType(element.food.foodType)!)
            .toLowerCase();
        String _filterQuery = filterQuery.toLowerCase();
        bool matchesFilter = _getFoodType.contains(_filterQuery);
        return matchesFilter;
      }).toList();
    } else if (query.isNotEmpty) {
      foodSuggestion = foodList.where((element) {
        String _getFoodName = element.food.foodName.toLowerCase();
        String _query = query.toLowerCase();
        bool matches = _getFoodName.contains(_query);
        return matches;
      }).toList();
    } else {
      foodSuggestion = <SavedMeal>[];
    }
  }

  void updateWith(
      {List<SavedMeal>? foodList,
      String? query,
      String? filterQuery,
      FoodType? foodType}) {
    this.foodList = foodList ?? this.foodList;
    this.query = query ?? this.query;
    this.filterQuery = filterQuery ?? this.filterQuery;
    this.foodType = foodType ?? this.foodType;
    notifyListeners();
  }
}
