import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? message;
  String? userName;

  Timestamp? time;
  String? uid;

  Chat({this.message, this.userName, this.time, this.uid});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'userName': userName,
      'time': time,
      'uid': uid,
    };
  }
}
