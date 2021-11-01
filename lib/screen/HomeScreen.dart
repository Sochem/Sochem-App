import 'package:flutter/material.dart';
import 'package:sochem/screen/LoginScreen.dart';
import 'package:sochem/utils/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import "LoginScreen.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:Text('SOCHEM APP'))),
      body: Center(
          child:Column(children: [Text("Home Screen",textScaleFactor: 2,),
                                  ElevatedButton(onPressed: () {
                                                 setLogout();
                                                 Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                                               );
                                                },
                                  child: Text('logout'))
          ])
      )
      );
  }
}


void setLogout() async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false );
}
