import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/widgets/logoutpop.dart';
import '../models/people_model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<People> _people = [];
  Future<List<People>> fetchPeople() async {
    var response = await http
        .get(Uri.parse("https://api.sochem.org/api/family-list/"), headers: {
      HttpHeaders.authorizationHeader:
          'Token 262132f6ee56aba6dcdc9e7bd28ed1409fb45c98'
    });
    List<People> people = [];
    if (response.statusCode == 200) {
      var peopleJson = json.decode(response.body);
      for (var peoplesJson in peopleJson) {
        people.add(People.fromJson(peoplesJson));
      }
    }
    return people;
  }

  String userEmail = '';
  String userName = '';
  String year = '';
  String initials = '';
  String house = '';
  String rollNo = '';

  @override
  void initState() {
    super.initState();
    fetchPeople().then((value) {
      setState(() {
        _people.addAll(value);
        _initialising();
      });
    });
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email')!;
      userName = prefs.getString('name')!;
      print(userName + "dev");
      initials = userName.substring(0, 1).toUpperCase();
      year = userEmail.substring(userEmail.length - 14, userEmail.length - 12);
      for (var i = 0; i < _people.length; i++) {
        if (_people[i].email == userEmail) {
          prefs.setString('house', _people[i].house!);
          prefs.setString('roll', _people[i].rollNo!);
          break;
        }
      }
      house = prefs.getString('house')!;
      rollNo = prefs.getString('roll')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: height,
              ),
              ShapeOfView(
                shape: ArcShape(
                  direction: ArcDirection.Outside,
                  height: 45,
                  position: ArcPosition.Bottom,
                ),
                child: Container(
                  height: height * 0.32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/profile_background.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: height * 0.2,
                    width: width * 0.3,
                    child: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.35,
                  ),
                  Center(
                    child: Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFECDF), kBackgroundColor],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.alternate_email_outlined,
                                  size: 35,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  child: Text(
                                    userEmail,
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFECDF), kBackgroundColor],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.class__outlined,
                                  size: 35,
                                ),
                              ),
                              Center(
                                child: Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                    child: Text(
                                      "Batch 20" + year,
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFECDF), kBackgroundColor],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.contacts_outlined,
                                  size: 35,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  child: Text(
                                    "Roll Number: " + rollNo,
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFECDF), kBackgroundColor],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.group_outlined,
                                  size: 35,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  child: Text(
                                    "You belong to \"" + house + "\"",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFECDF), kBackgroundColor],
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.logout_outlined,
                                  size: 35,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  child: GestureDetector(
                                    onTap: () => showLogOutPopup(context),
                                    child: Text(
                                      "Log Out",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
