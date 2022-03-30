import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = '';
  String userName = '';
  String year = '';
  String initials = '';

  @override
  void initState() {
    super.initState();
    _initialising();
  }

  void _initialising() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email')!;
      userName = prefs.getString('name')!;
      print(userName + "dev");
      initials = userName.substring(0, 1).toUpperCase();
      year = userEmail.substring(userEmail.length - 14, userEmail.length - 12);
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
                    height: height * 0.41,
                  ),
                  Center(
                    child: Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 80,
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
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 80,
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
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 80,
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
                                  Icons.format_quote_outlined,
                                  size: 35,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 5),
                                  child: Text(
                                    "Some deep motivational dialogue who no one follows",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 80,
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
                                    onTap: null,
                                    child: Text(
                                      "Log Out",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
