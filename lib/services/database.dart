import 'package:firebase_auth/firebase_auth.dart';

abstract class Database {
  Future<void> createUserinDatabase(User user);
  
}

class FirestoreDb implements Database{
  FirestoreDb(this.user);

  final User user;

  @override
  Future<void> createUserinDatabase(User user) {
    // TODO: implement createUserinDatabase
    throw UnimplementedError();
  }


 

}