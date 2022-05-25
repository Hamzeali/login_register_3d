import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'normal-textfield.dart';
import 'password-textField.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Icon accountIcon = Icon(
    Icons.account_circle,
    color: Colors.red,
  );
  double val = 0;
  bool switchScreen = true;
  Timer timer = Timer(Duration(seconds: 1), () {});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /**
   * Methode to verify if the user exist in the data base!
   */

  Future<void> verifyAccount(email, password) async {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {});
      final List<DocumentSnapshot> documents = querySnapshot.docs;
      /**
         * We are checking if the documents not empty (there is a data in our fire base)
         * if it is, then go to 'Home' Screen
         * We will implement 'Home' Screen later!!
         */
      if (documents.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email or Password is wrong!'),
          ),
        );
      }
    });
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
          ? Container(
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
                          'Login',
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
                      labelText: 'Username',
                      hintText: 'Enter email or username',
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PasswordTextField(
                      labelText: 'Password',
                      hintText: 'Enter you password...',
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          /**
                           * We need only to call our methode and pass the values!
                           */
                          verifyAccount(
                              emailController.text, passwordController.text);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'Don\'t have an account!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              val = pi;
                              timer = Timer(Duration(milliseconds: 500), () {
                                setState(() {
                                  switchScreen = false;
                                });
                              });
                            });
                          },
                          child: Text(
                            'Register now',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Register(),
    );
  }
}
