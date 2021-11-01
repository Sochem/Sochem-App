import 'package:flutter/material.dart';
import 'package:sochem/utils/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import "LoginScreen.dart";

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:Text('SOCHEM APP'))),
      body: Center(
          child:Column(children: [Text("Onboarding Screen",textScaleFactor: 2,),
                                  ElevatedButton(onPressed: () {
                                                 setOnBoarding();
                                                 Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                                               );
                                                },
                                  child: Text('Onboard!!!!'))
          ])
      ),
      );
  }
}


void setOnBoarding() async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setBool('isOnBoarded', true );
}
