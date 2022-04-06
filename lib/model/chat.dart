

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelapp/authentication/userauthentication.dart';

class Chat {
  String? message;
  String? userName;
  String? userImg;
  Timestamp? time;
  String? uid;

  Chat({ this.message, this.userName, this.userImg, this.time, this.uid});


  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'userName': userName,
      'userImg': userImg,
      'time': time,
      'uid': uid,
    };
  }
}

