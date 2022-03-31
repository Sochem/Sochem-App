import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/notification_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/carousel.dart';
import 'package:sochem/widgets/gridcards.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool newNotifExist = false;
  String userName = '';
  String initials = '';
  bool guest = true;

  Future<void> fetchNotifs() async {
    var response = await http.get(
      Uri.parse("https://api.sochem.org/api/notifi/"),
      headers: {HttpHeaders.authorizationHeader: dotenv.get(GuestToken)},
    );
    List<Notifications> notifs = [];
    if (response.statusCode == 200) {
      var peopleJson = json.decode(response.body);
      for (var peoplesJson in peopleJson) {
        notifs.add(Notifications.fromJson(peoplesJson));
      }
    }
    if (notifs.isNotEmpty) {
      int newId = int.parse(notifs.last.id);
      int oldId = 0;
      var prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(lastNotifId)) {
        oldId = prefs.getInt(lastNotifId)!;
      } else {
        prefs.setInt(lastNotifId, 0);
      }
      newNotifExist = oldId < newId;
    }
  }

  @override
  void initState() {
    super.initState();
    _initialising();
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    await fetchNotifs();
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
                  offset: const Offset(1.0, 1.0), //Offset
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
                  padding: EdgeInsets.fromLTRB(screensize.width * 0.035,
                      screensize.height * 0.03, 0.0, screensize.height * 0.005),
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
                                  radius: 25,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 30,
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
                        width: screensize.width * 0.42,
                        child: guest
                            ? Flexible(
                                child: Text(
                                  "Guest",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                      // letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              )
                            : Flexible(
                                child: Text(
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
                      ),
                      SizedBox(
                        width: screensize.width * 0.1,
                      ),
                      Row(children: [
                        IconButton(
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
                              : Navigator.pushNamed(context, NotifRoute),
                          icon: Icon(
                            CupertinoIcons.info_circle,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        IconButton(
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
                              : Navigator.pushNamed(context, NotifRoute),
                          icon: Icon(
                            CupertinoIcons.bell,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        if (newNotifExist)
                          Positioned(
                            right: 9,
                            top: 7,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              maxRadius: 6,
                              minRadius: 6,
                            ),
                          ),
                      ]),
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
                          fontSize: screensize.width * 0.085,
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
