import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/authentication/userauthentication.dart';
import 'package:travelapp/components/customPasswordTextField.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/main.dart';
import 'package:travelapp/screens/login.dart';

class Registration extends StatefulWidget {
  static const id = '/registration';
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final nameField = TextFormField(
        autofocus: false,
        controller: registrationController.nameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your username");
          }
          if (value.length < 3) {
            return ("Username is too short");
          }
          return null;
        },
        onSaved: (value) {
          registrationController.nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final emailField = TextFormField(
        autofocus: false,
        controller: registrationController.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          registrationController.emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final phoneField = TextFormField(
        autofocus: false,
        controller: registrationController.phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.length != 10) {
            return 'Phone number is not valid.';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          registrationController.phoneController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

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
      form.save();
      final userAuthentication = UserAuthentication();
      userAuthentication.signUp(registrationController.emailController.text,
          registrationController.passwordController.text);
    }
  }
}

void getSnackBar({String? title, String? message, Color? color}) {
  Get.snackbar(
    title!,
    message!,
    backgroundColor: color,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 3),
    borderRadius: 10.0,
  );
}
