import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String? name;
  final String? age;
  final String? favHobby;

  UserInfo({
    this.name,
    this.age,
    this.favHobby,
  });

  factory UserInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInfo(
      name: data?['name'],
      age: data?['age'],
      favHobby: data?['favHobby'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (favHobby != null) "favHobby": favHobby,
    };
  }
}