import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/components/customPasswordTextField.dart';
import 'package:travelapp/components/customTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/main.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/utils/utils.dart';

class Registration extends StatelessWidget {
  static const id = '/registration';
  Registration({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final nameField =
        NameTextField(nameController: registrationController.nameController);
    final emailField =
        EmailTextField(textController: registrationController.emailController);

    final phoneField =
        PhoneTextField(textController: registrationController.phoneController);

    //password field
    final passwordField = CustomPasswordTextField(
        controller: registrationController.passwordController);

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
                              "Register",
                              style: GoogleFonts.laila(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          nameField,
                          SizedBox(
                            height: size.height * 0.030,
                          ),
                          emailField,
                          SizedBox(
                            height: size.height * 0.030,
                          ),
                          phoneField,
                          SizedBox(
                            height: size.height * 0.030,
                          ),
                          passwordField,
                          SizedBox(
                            height: size.height * 0.04,
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
                                  onPressed: _handleRegister,
                                  child: Text(
                                    "Register",
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
                                'Already have an account?',
                                style: GoogleFonts.laila(
                                  fontSize: 12.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(LogInScreen.id);
                                },
                                child: Text(
                                  'LogIn here',
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

  Future<void> _handleRegister() async {
    final FormState? form = _formKey.currentState;

    if (form!.validate()) {
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
      form.save();
      userAuthentication.signUp(registrationController.emailController.text,
          registrationController.passwordController.text);
      registrationController.nameController.clear();
      registrationController.emailController.clear();
      registrationController.phoneController.clear();
      registrationController.passwordController.clear();
    }
  }
}
