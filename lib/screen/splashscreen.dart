import 'package:flutter/material.dart';
import 'package:sochem/utils/constants.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  

  decideScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var onboarded = await prefs.getBool('isOnBoarded');
  var login = await prefs.getBool('isLoggedIn');
                if(onboarded==true)
                     if(login==true)
                           return HomeScreen();
                     else
                           return LoginScreen();
                else
                      return OnboardingScreen();
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
    print('in build');
    var top = new Color.fromRGBO(22,71,119,1);
    var bottom = new Color.fromRGBO(24,134,191,1);
    var textclr = new Color.fromRGBO(39,88,124,1);
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
                      Text('SO',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:textclr)),
                      Text('CHEM',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.white))
                    ]
                )
              ]
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end : Alignment.bottomCenter,
                colors: [top,bottom]
            ),
          ),
        )
    );
  }
}




























//dummy screens

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



class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:Text('SOCHEM APP'))),
      body: Center(
          child:Column(children: [Text("Login Screen",textScaleFactor: 2,),
                                  ElevatedButton(onPressed: () {
                                                 setLogin();
                                                 Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => HomeScreen()),
                                                               );
                                                },
                                  child: Text('login'))
          ])
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:Text('SOCHEM APP'))),
      body: Center(
          child:Column(children: [Text("Onboarding Screen",textScaleFactor: 2,),
                                  ElevatedButton(onPressed: () {
                                                 setOnB();
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

void setOnB() async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setBool('isOnBoarded', true );
}

void setLogin() async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true );
}

void setLogout() async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false );
}
