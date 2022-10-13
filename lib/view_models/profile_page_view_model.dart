import 'package:dietri/helper/enums.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel with ChangeNotifier {
  ProfileViewModel({required this.auth, required this.db,});
  final AuthBase auth;
  final Database db;

  bool isLoading = false;


  Future<void> signOut() async{
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserGender(Gender gender) async {
   updateWith(isLoading: true);
    try {
      await db.updateUserGender(auth.currentUser!.uid, gender);
    } catch (e) {
      updateWith(isLoading: true);
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

   Future<void> updateUserGoals(Goals goals) async {
    updateWith(isLoading: true);
    try {
      await db.updateUserGoals(auth.currentUser!.uid, goals);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }


   Future<void> updateUserWeight(Weight weight,
      String weightString,) async {
        updateWith(isLoading: true);
    try {
      await db.updateUserWeight(uid: auth.currentUser!.uid, weight: weight, weightParam: weightString);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }

  }

   String getGoalString(Goals? goal) {
      switch (goal) {
        case Goals.gainweight:
          return 'Gain weight';
        case Goals.looseweight:
          return 'Lose weight';
        case Goals.maintainweight:
          return 'Maintain weight';
        default:
          return '';
      }
    }

    String getGenderString(Gender gender){
      switch (gender) {
        case Gender.male:
          return 'Male';
         case Gender.female:
          return 'Female';
         case Gender.others:
          return 'Others';
        default:
        return '';
      }
    }

   Weight getWeight(String weightParam){
    switch (weightParam) {
      case 'lb':
        return Weight.lb;
       case 'st':
        return Weight.st;
       case 'kg':
        return Weight.kg;
      default:
      return Weight.kg;
    }
   } 
   
  void updateWith({
 
    bool? isLoading
  }) {
    
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }
}
