import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.photoURL,
    this.gender,
    this.isKYCComplete,
    this.goal,
    this.weight,
    this.weightParam,
  });
  final String name;
  final String email;
  final String? photoURL;
  final bool? isKYCComplete;
  final Gender? gender;
  final Goals? goal;
  final String? weight;
  final String? weightParam;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'isKYCComplete': isKYCComplete,
      'gender': UserUtils.genderToInt(gender),
      'goal': UserUtils.goalToInt(goal),
      'weight': weight,
      'weightParam': weightParam,
    };
  }
  

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'] ?? '',
      isKYCComplete: map['isKYCComplete'] ?? false,
      gender: UserUtils.intToGender(map['gender']) ?? Gender.others,
      goal: UserUtils.intToGoal(map['goal']) ?? Goals.maintainweight,
      weight: map['weight'] ?? '',
      weightParam: map['weightParam'] ?? '',
    );
  }
}
