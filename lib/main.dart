import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelapp/controllers/logincontroller.dart';
import 'package:travelapp/controllers/registrationcontroller.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/navigationtab/profile.dart';
import 'package:travelapp/screens/confirmverification.dart';
import 'package:travelapp/screens/favourites.dart';
import 'package:travelapp/screens/forgotpassword.dart';
import 'package:travelapp/screens/homescreen.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/screens/register.dart';
import 'package:travelapp/screens/welcome.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:travelapp/utils/search.dart';

final RegistrationController registrationController = RegistrationController();
final LogInController logInController = LogInController();

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
    return KhaltiScope(
        publicKey: "test_public_key_9b21f8a777ab4b17bf841d0fecfb23b1",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            initialRoute: WelcomeScreen.id,
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            defaultTransition: Transition.fade,
            // home: Registration(),
            getPages: [
              GetPage(
                  name: WelcomeScreen.id, page: () => const WelcomeScreen()),
              GetPage(name: MainScreen.id, page: () => const MainScreen()),
              GetPage(name: Profile.id, page: () => const Profile()),
              GetPage(name: SearchPage.id, page: () => const SearchPage()),
              GetPage(name: Favourite.id, page: () => const Favourite()),
              GetPage(
                  name: ForgotPasswordScreen.id,
                  page: () => ForgotPasswordScreen()),
              GetPage(name: HomePage.id, page: () => const HomePage()),
              GetPage(
                  name: ConfirmEmailVerification.id,
                  page: () => const ConfirmEmailVerification()),
              GetPage(
                  curve: Curves.easeIn,
                  transition: Transition.upToDown,
                  name: LogInScreen.id,
                  page: () => LogInScreen()),
              GetPage(
                  curve: Curves.easeIn,
                  transition: Transition.downToUp,
                  name: Registration.id,
                  page: () => Registration()),
            ],
          );
        });
  }
}
