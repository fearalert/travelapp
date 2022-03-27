import 'package:flutter/material.dart';
import 'package:travelapp/constants/constants.dart';

class DialogBox extends StatelessWidget {
  final String title;
  const DialogBox(Center center, {Key? key, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kPrimaryColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 10.0,
      // insetAnimationDuration: Duration(seconds: 3),
      // insetPadding: EdgeInsets.all(25.0),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(
                kPrimaryColor,
              ),
              // value: 0.5,
              backgroundColor: kPrimaryColor.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              title + '...Please Wait...',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
