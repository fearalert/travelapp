import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/components/customPasswordTextField.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/main.dart';
import 'package:travelapp/screens/forgotpassword.dart';
import 'package:travelapp/screens/register.dart';
import 'package:travelapp/utils/utils.dart';

class LogInScreen extends StatelessWidget {
  static const id = '/login';
  LogInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final emailField =
        EmailTextField(textController: logInController.emailController);

    //password field
    final passwordField =
        CustomPasswordTextField(controller: logInController.passwordController);
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body: Form(
          key: _formKey,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                              "Login",
                              style: GoogleFonts.laila(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),

                          emailField,
                          SizedBox(height: size.height * 0.025),
                          passwordField,

                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(ForgotPasswordScreen.id);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.laila(
                                    fontSize: 12.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.035,
                              ),
                            ],
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
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                    shadowColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                  ),
                                  onPressed: _handleLogin,
                                  child: Text(
                                    "LogIn",
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
                                'Don\'t have an account?',
                                style: GoogleFonts.laila(
                                  fontSize: 12.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Registration.id);
                                },
                                child: Text(
                                  'Register here',
                                  style: GoogleFonts.laila(
                                    fontSize: 13.0,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Future<String?> _handleLogin() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      Get.dialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: kPrimaryColor,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      );

      userAuthentication.signIn(logInController.emailController.text,
          logInController.passwordController.text);
    }
    return null;
  }
}
