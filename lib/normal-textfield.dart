import 'package:flutter/material.dart';

class NormalTextField extends StatelessWidget {
  Icon prefixIcon;
  String labelText;
  String hintText;
  // We will add a controller to our Text Field Widget
  TextEditingController controller;

  NormalTextField(
      {required this.prefixIcon,
      required this.labelText,
      required this.hintText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.red,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          alignLabelWithHint: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
