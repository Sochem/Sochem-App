import 'package:flutter/material.dart';
import 'package:sochem/screen/home_screen.dart';
import 'package:sochem/utils/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('SOCHEM APP'))),
      body: Center(
          child: Column(children: [
        Text(
          "Login Screen",
          textScaleFactor: 2,
        ),
        ElevatedButton(
            onPressed: () {
              setLogin();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text('login'))
      ])),
    );
  }
}

void setLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
}
