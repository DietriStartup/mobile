import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/services/api_path.dart';
import 'package:dietri/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Database {
  Future<void> createUserinDatabase(User user);
  Future<void> updateUserGender(String uid, Gender gender);
  Future<void> updateUserGoals(String uid, Goals goal);
  Future<void> updateUserWeight(
      String uid, Weight weight, String weightParam, bool isKYCComplete);
  Stream<UserModel?> userStream(String uid);
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
}
