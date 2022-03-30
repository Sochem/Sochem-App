import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/screen/login_page.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/carousel.dart';
import 'package:sochem/widgets/gridcards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String initials = '';
  bool guest = true;

  @override
  void initState() {
    super.initState();
    _initialising();
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name')!;
      initials = userName.substring(0, 1).toUpperCase();
      guest = !prefs.getBool('isLoggedIn')!;
      print(userName + "dev");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
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
                  color: Colors.black54,
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
            height: screensize.height * 0.28,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25.0, screensize.height * 0.03,
                      10.0, screensize.height * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7.0),
                        child: GestureDetector(
                          onTap: () => guest
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "You need to be signed in with your institute ID",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor:
                                        Color(0xFFE8F1F8).withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 5,
                                  ),
                                )
                              : Navigator.pushNamed(
                                  context,
                                  '/profile',
                                ),
                          child: guest
                              ? CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  radius: 30,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 40,
                                      )),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  radius: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      initials,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: screensize.width * 0.4,
                        child: guest
                            ? Text(
                                "Guest",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              )
                            : Text(
                                userName,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white,
                                    // letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        width: screensize.width * 0.15,
                      ),
                      IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () => guest
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "You need to be signed in with your institute ID",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    backgroundColor:
                                        Color(0xFFE8F1F8).withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 5,
                                  ),
                                )
                              : Navigator.pushNamed(
                                  context,
                                  '/notif',
                                ),
                          icon: Icon(
                            CupertinoIcons.bell,
                            color: Colors.white,
                            size: 30.0,
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 25.0, top: screensize.height * 0.01),
                    child: Text(
                      "Society Of",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: screensize.width * 0.087,
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
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Chemical Engineers",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: screensize.width * 0.082,
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
            height: screensize.height * 0.52,
            child: HomeScreenGrid(),
          ),
          HomeScreenCarousel(),
        ],
      ),
    );
  }
}

void setLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(isLoggedIn, false);
}
