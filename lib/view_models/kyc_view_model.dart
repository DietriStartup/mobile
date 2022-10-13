import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/cupertino.dart';

class KYCViewModel with ChangeNotifier {
  KYCViewModel({
    required this.db,
    required this.auth,
  });
  final Database db;
  final AuthBase auth;
  Gender? gender;
  Goals? goals;
  Weight weight = Weight.kg;
  int currentPage = 0;
  final int numPages = 4;

  void updateGender(Gender? gender) => updateWith(gender: gender);

  void updateGoals(Goals? goals) => updateWith(goals: goals);

  void updateWeight(Weight? weight) => updateWith(weight: weight);

  void updateCurrentPage(int page) => updateWith(currentPage: page);

  Future<void> updateUserParams(
      {Gender? gender,
      Goals? goals,
      Weight? weight,
      String? weightString,
      bool? isKYCComplete}) async {
    try {
      if (gender != null) {
        await db.updateUserGender(auth.currentUser!.uid, gender);
      }
      if (goals != null) {
        await db.updateUserGoals(auth.currentUser!.uid, goals);
      }
      if (weight != null && weightString != null && isKYCComplete != null) {
        await db.updateUserWeight(
            uid: auth.currentUser!.uid, weight: weight, weightParam: weightString, isKYCComplete: isKYCComplete);
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void updateWith({
    Gender? gender,
    Goals? goals,
    Weight? weight,
    int? currentPage,
  }) {
    this.gender = gender ?? this.gender;
    this.goals = goals ?? this.goals;
    this.weight = weight ?? this.weight;
    this.currentPage = currentPage ?? this.currentPage;
    notifyListeners();
  }
}
