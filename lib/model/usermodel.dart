import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phoneNo;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.phoneNo,
  });

// data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phoneNo: map['phoneNo'],
    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNo': phoneNo,
    };
  }

  userDataStream() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}
