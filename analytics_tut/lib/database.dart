import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  final FirebaseFirestore _db;
  UserHelper(this._db);

  Future saveUser(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "score": 0,
    };
    final userRef = _db.collection("users").doc(user.email);
    if (!(await userRef.get()).exists) {
      await userRef.set(userData);
    }
  }

  Future updateUser(User user) async {
    final userRef = _db.collection("users").doc(user.email);
    final snapshot = await userRef.get();
    Map<String, dynamic> data = snapshot.data();
    userRef.update({"score": (data["score"] + 1)});
  }
}
