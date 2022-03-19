import 'package:flutter/material.dart';
import 'package:travelapp/constants/constants.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  const CustomPasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObscure = true;
  IconData eyeIcon = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: widget.controller,
        obscureText: isObscure,
        validator: (value) {
          Pattern pattern = r'^.{6,}$';
          RegExp regex = RegExp(pattern as String);
          if (value!.isEmpty) {
            return ("Please enter your password.");
          }
          if (!regex.hasMatch(value)) {
            return ' Password must be at least 6 characters.';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          widget.controller.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObscure = !isObscure;
                if (isObscure) {
                  eyeIcon = Icons.visibility_off;
                  print('iconOff');
                } else {
                  eyeIcon = Icons.visibility;
                  print('icon');
                }
              });
            },
            child: Icon(
              eyeIcon,
              color: kPrimaryColor,
            ),
          ),
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
