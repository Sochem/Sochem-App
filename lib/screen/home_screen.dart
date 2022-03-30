import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/notification_model.dart';
import 'package:sochem/screen/login_page.dart';
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
    fetchNotifs().then((value) {
      setState(() {});
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
                  padding: EdgeInsets.fromLTRB(25.0, screensize.height * 0.03,
                      10.0, screensize.height * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 7.0),
                        child: ClipOval(
                          child: InkWell(
                            onLongPress: () {
                              setLogout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Image.asset(
                              ExampleProfile,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screensize.width * 0.35,
                        child: Text(
                          "USERNAME",
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
                        width: screensize.width * 0.25,
                      ),
                      Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/notif',
                            ),
                            icon: ImageIcon(
                              AssetImage(BellIcon),
                              size: 25.0,
                              color: Colors.white,
                            ),
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
                          )
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
