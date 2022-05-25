import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  String labelText;
  String hintText;
  TextEditingController controller;

  PasswordTextField(
      {required this.labelText,
      required this.hintText,
      required this.controller});
  @override
  _PasswordTextFieldState createState() =>
      _PasswordTextFieldState(labelText, hintText, controller);
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  String labelText;
  String hintText;
  TextEditingController controller;

  _PasswordTextFieldState(this.labelText, this.hintText, this.controller);

  bool showPassword = false;
  Icon visOn = Icon(
    Icons.visibility,
    color: Colors.white,
  );
  Icon visOff = Icon(
    Icons.visibility_off,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.red,
        style: TextStyle(color: Colors.white),
        obscureText: showPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          prefixIcon: Icon(
            Icons.security,
            color: Colors.red,
          ),
          suffixIcon: IconButton(
            icon: showPassword ? visOff : visOn,
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
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
