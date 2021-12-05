import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/carousel.dart';
import 'package:sochem/widgets/gridcards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                color: kPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(
                      1.0,
                      1.0,
                    ), //Offset
                    blurRadius: 30.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              padding: EdgeInsets.only(top: 25.0),
              height: MediaQuery.of(context).size.height * 0.30,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 16.0, left: 20.0, right: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7.0),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile.jpeg',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            "USERNAME",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                // letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                        IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/bell.png'),
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.026,
                        ),
                        IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/menu.png'),
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Society Of",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            // letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Chemical Engineers",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            // letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.52,
              child: GridCards(),
            ),
            ComplicatedImageDemo(),
          ],
        ),
      ),
    );
  }
}
