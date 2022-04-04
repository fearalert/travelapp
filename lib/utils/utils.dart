import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/authentication/userauthentication.dart';

final userAuthentication = UserAuthentication();

User? user = FirebaseAuth.instance.currentUser;

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
