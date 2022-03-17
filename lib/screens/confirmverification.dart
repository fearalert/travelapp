import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/navigationtab/homepage.dart';
import 'package:travelapp/screens/register.dart';
import 'package:travelapp/utils/utils.dart';

class ConfirmEmailVerification extends StatelessWidget {
  static const id = '/confiemverification';

  const ConfirmEmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Stack(children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: size.height * 0.08),
                      Center(
                        child: Text(
                          "Email Verification",
                          style: GoogleFonts.laila(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      Center(
                        child: Text(
                          'We have sent you an verification link. Please check your email for the verification link.',
                          style: GoogleFonts.laila(),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 260.0,
                            height: 50.0,
                            child: ElevatedButton(
                                child: Text(
                                  "Confirm Verification",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                  shadowColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                ),
                                onPressed: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              CircularProgressIndicator(
                                                color: kPrimaryColor,
                                                backgroundColor: Colors.white,
                                              ),
                                            ],
                                          ));
                                  await userAuthentication.reload();
                                  // const CircularProgressIndicator();
                                  if (await userAuthentication
                                          .isEmailVerified() ==
                                      true) {
                                    Get.back();
                                    Get.offAllNamed(HomePage.id);
                                    getSnackBar(
                                      title: 'CONGRATULATIONS!',
                                      message: 'Your email has been verified',
                                      color: Colors.green.shade300,
                                    );
                                  } else {
                                    await userAuthentication.logOut();
                                    Get.back();
                                    getSnackBar(
                                      title: 'ERROR!',
                                      message:
                                          'Your email has not been verified',
                                      color: Colors.red.shade300,
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive a link? Click Resend.',
                            style: GoogleFonts.laila(
                              fontSize: 12.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(HomePage.id);
                              userAuthentication.sendEmailVerification();
                            },
                            child: Text(
                              'Resend',
                              style: GoogleFonts.laila(
                                fontSize: 16.0,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
