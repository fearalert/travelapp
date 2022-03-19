import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final double height;
  final double width;
  final Color color;

  const CustomButton({
    Key? key,
    required this.ontap,
    required this.text,
    required this.height,
    required this.width,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: kPrimaryColor),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(3, 7), // changes position of shadow
                ),
              ]),
          child: Center(
            child: Text(text,
                style: GoogleFonts.laila(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ));
  }
}
