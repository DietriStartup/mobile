import 'dart:convert';

class Food {
  Food({
    required this.foodName,
    required this.foodURL,
    required this.foodId,
    this.isSavedMeal,
    required this.foodIngredients,
    required this.foodType,
    required this.procedure,
  });
  final String foodName;
  final String foodIngredients;
  final String foodURL;
  int foodType;
  final String foodId;
  final bool? isSavedMeal;
  final List<dynamic> procedure;

  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'foodIngredients': foodIngredients,
      'foodType': foodType,
      'procedure': procedure,
      'isSavedMeal': isSavedMeal ?? false
    };
  }

  factory Food.fromMap(Map<String, dynamic>? map, String docId) {
    return Food(
        foodId: docId,
        foodName: map?['foodName'] ?? '',
        foodURL: map?['foodURL'] ?? '',
        foodIngredients: map?['foodIngredients'] ?? '',
        foodType: map?['foodType'] ?? 0,
        procedure: map?['procedure'] ?? [],
        isSavedMeal: map?['isSavedMeal'] ?? false);
  }
}
