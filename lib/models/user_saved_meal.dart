

class UserSavedMeal {
  UserSavedMeal({required this.foodId, required this.isSavedMeal});
  final String foodId;
  
  final bool? isSavedMeal;

  toMap() {
    return <String, dynamic>{
      'isSavedMeal' : isSavedMeal
    };
  }


  

  factory UserSavedMeal.fromMap(Map<String, dynamic>? map, String docId) {
    return UserSavedMeal(
      foodId: docId,
      isSavedMeal: map?['isSavedMeal']
    );
  }

}
