import 'package:flutter/material.dart';
import 'package:sochem/utils/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import "LoginScreen.dart";
import "HomeScreen.dart";
import 'OnBoardingScreen.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  decideScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  const CheckOnBoarded= 'isOnBoarded';
  const CheckLogIn = 'isLoggedin';
  var onboarded =  prefs.getBool(CheckOnBoarded);
  var login =  prefs.getBool(CheckLogIn);
                if(onboarded==true)
                {
                     if(login==true)
                          {
                           return HomeScreen();
                          }
                     else
                          {
                           return LoginScreen();
                          }
                }
                else
                    {
                      return OnboardingScreen();
                    }
  }



  void initState()  {
    super.initState();
    var screen ;
    decideScreen().then((scr){ 
          screen = scr ;
          Timer(Duration(seconds: 6),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:(context){
              return screen;
            }
            )
        )
       );
      }
    );
  }

  Widget build(BuildContext context) {
    var blue1 = new Color.fromRGBO(22,71,119,1);
    var blue2 = new Color.fromRGBO(24,134,191,1);
    var blue3 = new Color.fromRGBO(39,88,124,1);
    return Scaffold(
        body:Container(
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
                SizedBox(height:200),
                Center(child:Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/sochem.jpeg'),
                                      ),
                              ),
                     ),
                  ),
                SizedBox(height:200),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SO',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:blue3)),
                      Text('CHEM',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.white))
                    ]
                )
              ]
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end : Alignment.bottomCenter,
                colors: [blue1,blue2]
            ),
          ),
        )
    );
  }
}
