import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/screens/register.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: const Color(0xffffffff),
      // navigateRoute: userAuthentication.currentUser == null
      //     ? Registration()
      //     : const HomePage(),
      navigateRoute: Registration(),
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
