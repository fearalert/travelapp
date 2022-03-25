import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/components/buttons.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/main.dart';

class Profile extends StatelessWidget {
  static const id = '/profile';
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kPrimaryColor, kSecondaryColor])),
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.trendrr.net/wp-content/uploads/2017/06/Deepika-Padukone-1.jpg",
                        ),
                        radius: 50.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Simran Ghimire",
                        style: GoogleFonts.laila(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EmailTextField(
                  // textController: profileController.emailController,
                  textController: registrationController.emailController,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                ontap: () {},
                text: 'cancel',
                height: 55.0,
                width: 180.0,
                color: Colors.red.shade400,
              ),
              CustomButton(
                ontap: () {},
                text: 'Save Changes',
                height: 55.0,
                width: 180.0,
                color: kPrimaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
