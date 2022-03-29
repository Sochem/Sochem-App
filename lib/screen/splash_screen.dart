import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/screen/home_screen.dart';
import 'package:sochem/screen/login_page.dart';
import 'package:sochem/screen/onboarding_screen.dart';
import 'dart:async';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  decideScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var onboarded = prefs.getBool(hasOnboarded);
    var login = prefs.getBool(isLoggedIn);
    if (onboarded == true) {
      if (login == true) {
        return HomeScreen();
      } else {
        return LoginPage();
      }
    } else {
      return OnboardingScreen();
    }
  }

  void initState() {
    super.initState();
    var screen;
    decideScreen().then((scr) {
      screen = scr;
      Timer(
          Duration(seconds: 6),
          () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return screen;
              })));
    });
  }

  Widget build(BuildContext context) {
    var blue1 = new Color.fromRGBO(22, 71, 119, 1);
    var blue2 = new Color.fromRGBO(24, 134, 191, 1);
    var blue3 = new Color.fromRGBO(39, 88, 124, 1);
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue1, blue2]),
        ),
      ),
      Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(SochemIcon),
            ),
          ),
        ),
      ),
      Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.fromLTRB(
              0, 0, 0, MediaQuery.maybeOf(context)!.size.height / 15),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SO',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: blue3)),
                Text('CHEM',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ]))
    ]));
  }
}
