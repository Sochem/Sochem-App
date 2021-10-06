import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: Bluepainter(),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sochem icon
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.6,
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
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child:

                          // Login button
                          ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.78, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    // Guest Buttton
                    TextButton(
                      onPressed: () {},
                      child: Text('Guest'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.78, 50),
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
    paint.color = Color.fromARGB(255, 58, 110, 196);
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle1, paint);

    // Upper triangle
    Path triangle2 = Path();
    triangle2.moveTo(0, 0);
    triangle2.lineTo(midx, midy);
    triangle2.lineTo(width, 0);
    triangle2.close();
    paint.color = Color.fromARGB(255, 86, 134, 182);
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle2, paint);

    // Right traingle
    Path triangle3 = Path();
    triangle3.moveTo(width, 0);
    triangle3.lineTo(midx, midy);
    triangle3.lineTo(width, height);
    triangle3.close();
    paint.color = Color.fromARGB(255, 64, 99, 141);
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle3, paint);

    //Lower traingle
    Path triangle4 = Path();
    triangle4.moveTo(0, height);
    triangle4.lineTo(midx, midy);
    triangle4.lineTo(width, height);
    triangle4.close();
    paint.color = Color.fromARGB(255, 58, 95, 176);
    paint.style = PaintingStyle.fill;
    canvas.drawPath(triangle4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
