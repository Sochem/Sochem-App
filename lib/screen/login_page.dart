import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/screen/home_screen.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // function
    Future<void> _signIn() async {
      final String _webClientId = dotenv.env['WEB_CLIENT_ID']!;

      final user =
          await GoogleOneTapSignIn.startSignIn(webClientId: _webClientId);
      print(GoogleOneTapSignIn.startSignIn(webClientId: _webClientId));
      print(user);

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        userEmail = user.username.toString();
        print('IdToken:  ${user.idToken}');
        print(user.username.toString() + " 3asdk");
        print(user.credential.toString() + " 4asdk");
        print(user.googleIdToken.toString() + " 5asdk");
        print(user.password + " 5asdk");
        print(user.id + " 6asdk");
        print(user.toString() + "asdk");
        var url = Uri.parse("https://api.sochem.org/api/logup");
        var response = await http.post(
          url,
          body: {
            'token': user.idToken.toString(),
          },
        );
        print(response.body.toString() + " 8asdk");
        djangoToken = response.body;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }

    return Scaffold(
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          return CustomPaint(
            painter: Bluepainter(),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sochem icon
                  Container(
                    width: width * 0.5,
                    height: height * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(SochemIcon),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),

                  //Buttons for login options
                  Container(
                    padding: EdgeInsets.only(bottom: height * 0.1),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          icon: Image.asset(
                            "assets/google_logo.png",
                            height: 35,
                          ),
                          onPressed: _signIn,
                          label: Text(
                            " LOGIN",
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                            ),
                            fixedSize: Size(width * 0.78, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.0,
                              width: 50.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              width: 50.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Guest Buttton
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool(isGuest, true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text('Guest'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            textStyle: TextStyle(
                              fontSize: 24,
                            ),
                            fixedSize: Size(width * 0.78, 50),
                            side: BorderSide(color: Colors.white, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// classes
class Bluepainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final midx = width * 0.5;
    final midy = height * 0.5;
    Paint paint = Paint();

    // Left triangle
    Path triangle1 = Path();
    triangle1.moveTo(0, 0);
    triangle1.lineTo(midx, midy);
    triangle1.lineTo(0, height);
    triangle1.close();
    paint.color = tri1;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle1, paint);

    // Upper triangle
    Path triangle2 = Path();
    triangle2.moveTo(0, 0);
    triangle2.lineTo(midx, midy);
    triangle2.lineTo(width, 0);
    triangle2.close();
    paint.color = tri2;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle2, paint);

    // Right traingle
    Path triangle3 = Path();
    triangle3.moveTo(width, 0);
    triangle3.lineTo(midx, midy);
    triangle3.lineTo(width, height);
    triangle3.close();
    paint.color = tri3;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle3, paint);

    //Lower traingle
    Path triangle4 = Path();
    triangle4.moveTo(0, height);
    triangle4.lineTo(midx, midy);
    triangle4.lineTo(width, height);
    triangle4.close();
    paint.color = tri4;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something Went Wrong")),
    );
  }
}
