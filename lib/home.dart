import 'package:flutter/material.dart';

/**
 * 
 * Our Home Widget is only to display a 'Welcome' Text
 */
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
