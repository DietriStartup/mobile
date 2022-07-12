import 'dart:convert';

class Food {
  Food(
      {required this.foodName,
      required this.foodURL, 
      required this.foodIngredients,
      required this.foodType,
      required this.procedure1,
      required this.procedure2,
      required this.procedure3});
  final String foodName;
  final String foodIngredients;
  final String foodURL;
  final int foodType;
  final String procedure1;
  final String procedure2;
  final String procedure3;


  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'foodIngredients': foodIngredients,
      'foodType': foodType,
      'procedure1': procedure1,
      'procedure2': procedure2,
      'procedure3': procedure3,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
     foodName:   map['foodName'] ?? '',
     foodURL: map['foodURL'] ?? '',
     foodIngredients: map['foodIngredients'] ?? '',
      foodType:map['foodType'] ?? 0,
      procedure1:map['procedure1'] ?? '',
      procedure2: map['procedure2'] ?? '',
      procedure3: map['procedure3'] ?? '',
    );
  }

 
}
