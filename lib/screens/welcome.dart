import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/screens/homescreen.dart';
import 'package:travelapp/screens/register.dart';
import 'package:travelapp/utils/utils.dart';
import 'package:travelapp/model/usermodel.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: const Color(0xffffffff),
      navigateRoute: FirebaseAuth.instance.currentUser == null
          ? Registration()
          : const MainScreen(),
      // navigateRoute: Registration(),
      duration: 3000,
      text: 'Tours & Travels',
      textStyle: GoogleFonts.arizonia(
        color: kPrimaryColor,
        fontSize: 50.0,
        fontWeight: FontWeight.bold,
      ),

      pageRouteTransition: PageRouteTransition.SlideTransition,
    );
  }
}
