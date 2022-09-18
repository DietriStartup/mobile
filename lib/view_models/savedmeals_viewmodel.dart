import 'dart:async';

import 'package:dietri/helper/enums.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class SavedMealsViewModel with ChangeNotifier {
  SavedMealsViewModel({required this.db, required this.auth});
  final Database db;
  final AuthBase auth;
  List<Food> foodList = [];
  List<Food> foodSuggestion = [];
  String query = '';
  StreamSubscription? _subscription;
  FoodType? foodType;


  Stream<List<Food>> userSavedMealStream() {
    return   db.userSavedMealStream(auth.currentUser!.uid);
  }

  void updateFoodList() {
    _subscription =
        db.userSavedMealStream(auth.currentUser!.uid).listen((event) {
      updateWith(foodList: event);
    });
  }

  void closeStream() => _subscription?.cancel();

  updateQuery(String query) => updateWith(query: query);
  updateFoodType(FoodType? foodType) => updateWith(foodType: foodType);

  void getFoodSearchResults() {
    if (query.isNotEmpty) {
      foodSuggestion = foodList.where((element) {
        String _getFoodName = element.foodName.toLowerCase();
        String _query = query.toLowerCase();
        bool matches = _getFoodName.contains(_query);
        return matches;
      }).toList();
    } else {
      foodSuggestion = <Food>[];
    }
  }

    Future<void> addNewMeal(Food food, String foodTypeString, FoodType foodType) async {
    try{
      await db.addNewMealPlan(
          food, auth.currentUser!.uid, foodTypeString, foodType);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
     rethrow;
    }
  }

  Future<void> deleteSavedMeal(Food food) async {
    try {
      await db.deleteSavedMeal(food.foodId, auth.currentUser!.uid);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateWith({List<Food>? foodList, String? query, FoodType? foodType}) {
    this.foodList = foodList ?? this.foodList;
    this.query = query ?? this.query;
    this.foodType = foodType ?? this.foodType;
    notifyListeners();
  }
}
