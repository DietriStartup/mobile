import 'dart:convert';

class Food {
  Food(
      {required this.foodName,
      required this.foodURL, 
      required this.foodIngredients,
      required this.foodType,
      required this.procedure,
    });
  final String foodName;
  final String foodIngredients;
  final String foodURL;
  final int foodType;
  final List<dynamic> procedure;



  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'foodIngredients': foodIngredients,
      'foodType': foodType,
      'procedure': procedure,
     
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
     foodName:   map['foodName'] ?? '',
     foodURL: map['foodURL'] ?? '',
     foodIngredients: map['foodIngredients'] ?? '',
      foodType:map['foodType'] ?? 0,
      procedure: map['procedure'] ?? [],
    );
  }

 
}
