import 'package:flutter/material.dart';
import 'package:travelapp/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;

  const CustomTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        obscureText: false,
        controller: textController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter text");
          }
          return null;
        },
        onSaved: (value) {
          textController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}

class NameTextField extends StatelessWidget {
  final TextEditingController nameController;
  const NameTextField({Key? key, required this.nameController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: nameController,
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
          nameController.text = value!;
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
  }
}

class EmailTextField extends StatelessWidget {
  final TextEditingController textController;

  const EmailTextField({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: textController,
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
          textController.text = value!;
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
  }
}

class PhoneTextField extends StatelessWidget {
  final TextEditingController textController;

  const PhoneTextField({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: textController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Please enter your phone number');
          } else if (value.length != 10) {
            return ("please enter a valid phone nuber");
          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
            return ("please enter a valid phone number");
          } else {
            return null;
          }
        },
        onSaved: (value) {
          textController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.call),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
