import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_project/firebase_model/userInfo.dart';


class UserFirebaseService {
  var db = FirebaseFirestore.instance;

  Future<UserInfo?> getUserFromFirebase(id) async {
    try {
      final docRef = db.collection("info").doc(id); //getting document with id
      DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
      if (doc.exists) {
        return UserInfo.fromFirestore(doc);
      } else {
        print("Document does not exist!");
        return null;
      }
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }
}
