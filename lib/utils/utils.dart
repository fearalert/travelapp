import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/authentication/userauthentication.dart';

DatabaseReference serviceRefrence =
    FirebaseDatabase.instance.reference().child('packages');

DatabaseReference adminRefrence =
    FirebaseDatabase.instance.reference().child('admin');

final userAuthentication = UserAuthentication();

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
