import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sochem/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> decideScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var onboarded = prefs.get(isOnboarded);
    var login = prefs.get(isLoggedIn);
    if (onboarded == true) {
      if (login == true) {
        return HomeRoute;
      } else {
        return LoginRoute;
      }
    } else {
      return OnboardingRoute;
    }
  }

  void initState() {
    super.initState();
    decideScreen().then((route) {
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, route),
      );
    });
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [blue1, blue2],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenSize.width * 0.55,
              height: screenSize.width * 0.55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(SochemIcon),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SO',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: blue3,
                    ),
                  ),
                  Text(
                    'CHEM',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
