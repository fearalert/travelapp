import 'package:flutter/material.dart';
import 'package:travelapp/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  final bool obsecure;
  final IconData icon;

  const CustomTextField({
    key,
    required this.textController,
    required this.hintText,
    required this.icon,
    required this.labelText,
    required this.obsecure,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color focuscolor = const Color.fromARGB(255, 159, 160, 161);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.073,
      width: size.width * 0.9,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Text is too short.';
          } else {
            return null;
          }
        },
        onTap: () {
          setState(() {
            focuscolor = kPrimaryColor;
          });
        },
        cursorColor: kPrimaryColor,
        controller: widget.textController,
        keyboardType: TextInputType.text,
        obscureText: widget.obsecure,
        style: const TextStyle(color: kPrimaryColor),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 20),
            child: Icon(
              widget.icon,
              color: focuscolor,
            ),
          ),
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: focuscolor, fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focuscolor, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focuscolor, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          filled: true,
          fillColor: kTextfieldColor,
          labelText: widget.labelText,
          labelStyle: TextStyle(color: focuscolor, fontSize: 14),
        ),
      ),
    );
  }
}
