import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/models/user_saved_meal.dart';
import 'package:dietri/services/api_path.dart';
import 'package:dietri/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Database {
  Future<void> createUserinDatabase(User user);
  Future<void> updateUserGender(String uid, Gender gender);
  Future<void> updateUserGoals(String uid, Goals goal);
  Future<void> updateUserWeight(
      String uid, Weight weight, String weightParam, bool isKYCComplete);
  Future<void> setUserSavedMeal(UserSavedMeal userSavedMeal, String uid);
  Stream<UserModel?> userStream(String uid);
  Stream<List<Food>> userMealPlanStream(String uid);
  Stream<List<Food>> mealPlanStream();
  Stream<List<UserSavedMeal>> userSavedMealStream(String uid);
  

}

class FirestoreDb implements Database {
  final _firestoreService = FirestoreService.instance;

  @override
  Future<void> createUserinDatabase(User? user) async {
    UserModel userModel = UserModel(
        name: user?.displayName ?? 'User',
        email: user?.email ?? '',
        photoURL: user?.photoURL ?? '');

    return await _firestoreService.setData(
        path: APIPath.userPath(id: user!.uid), data: userModel.toMap());
  }

  @override
  Future<void> updateUserGender(String uid, Gender gender) async =>
      await _firestoreService.updateData(
          path: APIPath.userPath(id: uid),
          data: {'gender': UserUtils.genderToInt(gender)});

  @override
  Future<void> updateUserGoals(String uid, Goals goal) async =>
      await _firestoreService.updateData(
          path: APIPath.userPath(id: uid),
          data: {'goal': UserUtils.goalToInt(goal)});
  @override
  Future<void> updateUserWeight(String uid, Weight weight, String weightParam,
          bool isKYCComplete) async =>
      await _firestoreService
          .updateData(path: APIPath.userPath(id: uid), data: {
        'weight': weightParam,
        'weightParam': UserUtils.getWeightString(weight),
        'isKYCComplete': isKYCComplete,
      });

  @override
  Stream<UserModel?> userStream(String uid) => _firestoreService.documentStream(
      path: APIPath.userPath(id: uid),
      builder: (data, docId) => UserModel.fromMap(data ?? {}));

  @override
  Stream<List<Food>> userMealPlanStream(String uid) =>
      _firestoreService.collectionStream(
          path: APIPath.mealPlanPath(id: uid),
          builder: (data, docId) {
           
            return Food.fromMap(data ?? {}, docId);
          });

  @override
  Stream<List<Food>> mealPlanStream() => _firestoreService.collectionStream(path: 'mealplans', builder: (data, docId) => Food.fromMap(data!, docId));

  @override
  Future<void> setUserSavedMeal(UserSavedMeal userSavedMeal, String uid) async {
    final data = userSavedMeal.toMap();
   return await _firestoreService.setData(path: APIPath.userSavedMeal(id: uid, docId: userSavedMeal.foodId), data: data); 
  }

  @override
  Stream<List<UserSavedMeal>> userSavedMealStream(String uid) => _firestoreService.collectionStream(path: APIPath.userSavedMeals(id: uid), builder: (data, docId) => UserSavedMeal.fromMap(data, docId) );



  
}
