import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/controllers/registrationcontroller.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/screens/confirmverification.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/screens/register.dart';
import 'package:travelapp/screens/welcome.dart';

final RegistrationController registrationController = RegistrationController();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Get.put(TextController());
    return GetMaterialApp(
      initialRoute: WelcomeScreen.id,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.fade,
      // home: Registration(),
      getPages: [
        GetPage(name: WelcomeScreen.id, page: () => const WelcomeScreen()),
        GetPage(name: HomePage.id, page: () => const HomePage()),
        GetPage(
            name: ConfirmEmailVerification.id,
            page: () => const ConfirmEmailVerification()),
        GetPage(
            curve: Curves.easeIn,
            transition: Transition.upToDown,
            name: LogInScreen.id,
            page: () => const LogInScreen()),
        GetPage(
            curve: Curves.easeIn,
            transition: Transition.downToUp,
            name: Registration.id,
            page: () => const Registration()),
      ],
    );
  }
}
