import 'package:dietri/components/show_bottom_modal_sheet.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/models/food.dart';
import 'package:flutter/material.dart';

class UserUtils {
  static Gender? intToGender(int? genderNumber) {
    switch (genderNumber) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      case 2:
        return Gender.others;
      default:
        return null;
    }
  }

  static int? genderToInt(Gender? gender) {
    switch (gender) {
      case Gender.male:
        return 0;
      case Gender.female:
        return 1;
      case Gender.others:
        return 2;
      default:
        return null;
    }
  }

  static Goals? intToGoal(int? goalNumber) {
    switch (goalNumber) {
      case 0:
        return Goals.gainweight;
      case 1:
        return Goals.maintainweight;
      case 2:
        return Goals.looseweight;
      default:
        return null;
    }
  }

  static int? goalToInt(Goals? goals) {
    switch (goals) {
      case Goals.gainweight:
        return 0;
      case Goals.maintainweight:
        return 1;
      case Goals.looseweight:
        return 2;
      default:
        return null;
    }
  }

  static String getWeightString(Weight? weight) {
    switch (weight) {
      case Weight.st:
        return 'st';
      case Weight.lb:
        return 'lb';
      case Weight.kg:
        return 'kg';
      default:
        return 'kg';
    }
  }

   static String getFoodTypeString(FoodType foodType) {
    switch (foodType) {
      case FoodType.breakfast:
        return 'Breakfast';
      case FoodType.lunch:
        return 'Lunch';
      case FoodType.dinner:
        return 'Dinner';
      default:
        return '';
    }
  }

  

  static int? foodTypetoInt(FoodType? foodType){
    switch (foodType) {
      case FoodType.breakfast:
        return 0;
      case FoodType.lunch:
        return 1;
      case FoodType.dinner:
        return 2;
      default:
      return null;
    }
  }

  static FoodType? intToFoodType(int? foodTypeNumber){
    switch (foodTypeNumber) {
      case 0:
      return FoodType.breakfast;
      case 1:
      return FoodType.lunch;
      case 2:
      return FoodType.dinner;
      default:
      return null;
    }
  }
   static  Future<dynamic> dietriModalBSheet(BuildContext context, Food food, double height) {
    return showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                useRootNavigator: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                isScrollControlled: true,
                                isDismissible: true,
                                builder: (BuildContext context) {
                                  return ShowModalContent(
                                      foodName: food.foodName,
                                      foodIngredients: food.foodIngredients,
                                      procedure: food.procedure,
                                      height: height);
                                });
}
}