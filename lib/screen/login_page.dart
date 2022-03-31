import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/utils/endpoints.dart';
import 'package:sochem/widgets/error_messages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _signIn() async {
    var _webClientId = dotenv.env[WebClientId]!;
    var user = await GoogleOneTapSignIn.startSignIn(
      webClientId: _webClientId,
    );
    var prefs = await SharedPreferences.getInstance();
    if (user != null) {
      var response = await http.post(
        Uri.parse(Endpoints.login),
        body: {'token': user.idToken.toString()},
      );
      if (response.statusCode != 200) {
        showLoginFailed(context);
        prefs.setBool(isLoggedIn, false);
        return;
      }
      var token =
          'Token ${response.body.substring(10, response.body.length - 2)}';
      prefs.setBool(isLoggedIn, true);
      prefs.setString(DjangoToken, token);
      prefs.setString(UserEmail, user.username.toString());
      prefs.setString(UserName, user.displayName.toString());
      Navigator.pushReplacementNamed(context, HomeRoute);
    } else {
      showLoginFailed(context);
      prefs.setBool(isLoggedIn, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomPaint(
        painter: Bluepainter(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width * 0.5,
                height: width * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBackgroundColor,
                  image: DecorationImage(
                    image: AssetImage(SochemIcon),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      icon: Image.asset(GoogleIcon, height: 35),
                      onPressed: _signIn,
                      label: Text(
                        " LOGIN",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        fixedSize: Size(width * 0.75, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.0,
                          width: 50.0,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setBool(isLoggedIn, false);
                        Navigator.pushReplacementNamed(context, HomeRoute);
                      },
                      child: Text('Guest'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        textStyle: TextStyle(
                          fontSize: 24,
                        ),
                        fixedSize: Size(width * 0.75, 50),
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
      ),
    );
  }
}

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
