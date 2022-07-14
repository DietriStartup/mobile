import 'package:dietri/models/food.dart';
import 'package:dietri/models/saved_meal_model.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:rxdart/rxdart.dart';

class SavedMealsViewModel {
  SavedMealsViewModel({
    required this.db,
    required this.auth,
  });
  final Database db;
  final AuthBase auth;

  Stream<List<SavedMeal>> savedMealsStream() {
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
}
