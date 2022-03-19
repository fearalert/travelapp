import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/model/usermodel.dart';

DatabaseReference serviceRefrence =
    FirebaseDatabase.instance.reference().child('packages');

DatabaseReference adminRefrence =
    FirebaseDatabase.instance.reference().child('admin');

final userAuthentication = UserAuthentication();

User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

@override
void initState() {
  FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((value) {
    loggedInUser = UserModel.fromMap(value.data());
  });
}

String formatTime({TimeOfDay? unformattedTime}) {
  String time = '';

  if (unformattedTime!.hourOfPeriod <= 9) {
    if (unformattedTime.hour == 12) {
      time += '${unformattedTime.hour}';
    } else {
      time += '0${unformattedTime.hourOfPeriod}';
    }
  } else {
    time += '${unformattedTime.hourOfPeriod}';
  }

  if (unformattedTime.minute <= 9) {
    time += ':0${unformattedTime.minute}';
  } else {
    time += ':${unformattedTime.minute}';
  }
  String periodOfDay = unformattedTime.period == DayPeriod.am ? ' am' : ' pm';
  return time + periodOfDay;
}
