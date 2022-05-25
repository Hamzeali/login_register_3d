import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_register_3d/login.dart';
import 'package:login_register_3d/normal-textfield.dart';
import 'package:login_register_3d/password-textField.dart';

import 'user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Icon accountIcon = Icon(
    Icons.account_circle,
    color: Colors.red,
  );
  Icon emailIcon = Icon(
    Icons.email,
    color: Colors.red,
  );

  Timer registerTimer = Timer(Duration(seconds: 1), () {});
  bool switchScreen = true;
  double val = 0;

  /**
   * controller for first name field
   */
  final firstNameController = TextEditingController();

  /**
   * controller for last name field
   */
  final lastNameController = TextEditingController();

  /**
   * controller for email field
   */
  final emailController = TextEditingController();

  /**
   * controller for password field
   */
  final passwordController = TextEditingController();

  /**
   * controller for confirm password field
   */
  final confirmPasswordController = TextEditingController();

  /**
   * Method to create and add a user to the data base!
   */

  Future createUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text);

    final json = user.toJson();

    /**
     * if statement to check if the fields empty or not
     * and to check if the 'password field' is equal to 
     * 'Confirm Password field'
     */

    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
      await docUser.set(json);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are registered!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: val),
      duration: Duration(seconds: 1),
      builder: (_, value, child) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(value),
        child: child,
        alignment: Alignment.bottomCenter,
      ),
      child: switchScreen
          ? Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(55.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NormalTextField(
                        prefixIcon: accountIcon,
                        labelText: 'First Name',
                        hintText: 'Enter your first name...',
                        controller: firstNameController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NormalTextField(
                        prefixIcon: accountIcon,
                        labelText: 'Last Name',
                        hintText: 'Enter your last name...',
                        controller: lastNameController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      NormalTextField(
                        prefixIcon: emailIcon,
                        labelText: 'Email',
                        hintText: 'Enter your email...',
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PasswordTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password...',
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PasswordTextField(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password...',
                        controller: confirmPasswordController,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            createUser();
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                val = pi;
                                registerTimer =
                                    Timer(Duration(milliseconds: 500), () {
                                  setState(() {
                                    switchScreen = false;
                                  });
                                });
                              });
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
          : Login(),
    );
  }
}
