import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';
import 'package:travelapp/controllers/textcontroller.dart';
import 'package:travelapp/screens/login.dart';
import 'package:travelapp/utils/utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const id = '/forgotpassword';
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textController = Get.put(TextController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final emailField = TextFormField(
        autofocus: false,
        controller: textController.emailController,
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
          textController.emailController.text = value!;
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
                              "Reset Password",
                              style: GoogleFonts.laila(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Text(
                              'An email will be sent to you, Visit the link to change your password.',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 2.0,
                                wordSpacing: 2.0,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.045),

                          emailField,
                          SizedBox(height: size.height * 0.025),

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
                                  onPressed: _handleSubmit,
                                  child: Text(
                                    "Send Reset Link",
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
                                'Remember Password?',
                                style: GoogleFonts.laila(
                                  fontSize: 12.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(LogInScreen.id);
                                },
                                child: Text(
                                  'Continue to Login',
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

  Future<String?> _handleSubmit() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      Get.dialog(Dialog(
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(20.0)),
          insetAnimationCurve: Curves.bounceIn,
          backgroundColor: const Color(0xFF110E1F),
          elevation: 2.0,
          insetPadding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 25.0,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    'Confirm Email',
                    style: GoogleFonts.laila(
                      color: Colors.black,
                      fontSize: 26,
                      letterSpacing: 2.0,
                      wordSpacing: 2.0,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 250.0,
                  child: Divider(
                    color: Colors.black38,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 20.0,
                    right: 18.0,
                    bottom: 18.0,
                  ),
                  child: Center(
                    child: Text(
                      'If you provided correct email,\nyou must have received password reset link in your maail & visit the link to change your password.',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 14.0,
                        letterSpacing: 2.0,
                        wordSpacing: 2.0,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff4f5b8a),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xff2f3650),
                          offset: Offset(0, 1),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )));

      form.save();
      userAuthentication.passwordReset(
          email: textController.emailController.text);
    }
    return null;
  }
}
