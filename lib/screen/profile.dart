import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/utils/endpoints.dart';
import 'package:sochem/models/people_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<People> _people = [];
  late String token;
  String userEmail = '';
  String userName = '';
  String year = '';
  String initials = '';
  String house = '';
  String rollNo = '';

  Future<List<People>> fetchPeople() async {
    var response = await http.get(
      Uri.parse(Endpoints.profile),
      headers: {HttpHeaders.authorizationHeader: token},
    );
    List<People> people = [];
    if (response.statusCode == 200) {
      var peopleJson = json.decode(response.body);
      for (var peoplesJson in peopleJson) {
        people.add(People.fromJson(peoplesJson));
      }
    }
    return people;
  }

  @override
  void initState() {
    _initialising();
    super.initState();
  }

  Future<void> _initialising() async {
    var prefs = await SharedPreferences.getInstance();
    token = prefs.getString(DjangoToken)!;
    userEmail = prefs.getString(UserEmail)!;
    userName = prefs.getString(UserName)!;
    initials = userName[0].toUpperCase();
    year = userEmail.substring(userEmail.length - 14, userEmail.length - 12);
    _people = await fetchPeople();
    setState(() {
      for (var i = 0; i < _people.length; i++) {
        if (_people[i].email == userEmail) {
          house = _people[i].house!;
          rollNo = _people[i].rollNo!;
          break;
        }
      }
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
                      image: AssetImage(ProfileBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: height * 0.2),
                  Center(
                    child: Container(
                      height: width * 0.3,
                      width: width * 0.3,
                      child: CircleAvatar(
                        backgroundColor: Colors.primaries[Random().nextInt(
                          Colors.primaries.length,
                        )],
                        radius: 30,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Divider(),
                        Container(
                          height: 70,
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
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.alternate_email_outlined,
                                size: 35,
                              ),
                              title: Text(
                                userEmail,
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 70,
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
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.class_outlined,
                                size: 35,
                              ),
                              title: Text(
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
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 70,
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
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.contacts_outlined,
                                size: 35,
                              ),
                              title: Text(
                                "Roll Number: " + rollNo,
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 70,
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
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.group_outlined,
                                size: 35,
                              ),
                              title: Text(
                                "You belong to \"" + house + "\"",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 70,
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
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.logout_outlined,
                                size: 35,
                              ),
                              title: GestureDetector(
                                onTap: () async {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  prefs.setBool(isOnboarded, true);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginRoute,
                                    (route) => false,
                                  );
                                },
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
                          ),
                        )
                      ],
                    ),
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
