import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/models/people_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:http/http.dart' as http;

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  String? _year;
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

  DropdownMenuItem<String> _getDropdown(String title, String value) {
    return DropdownMenuItem<String>(
      child: Text(title),
      value: value,
    );
  }

  List<String> _yearList = [];
  List<String> _yearGen() {
    _yearList = [];
    DateTime x = DateTime.now();
    var y = x.year;
    if (x.month <= 7) y--;
    while (y >= 2018) {
      _yearList.add("CHE " + y.toString().substring(2));
      y--;
    }
    var z = _yearList.reversed;

    return z.toList();
  }

  @override
  void initState() {
    super.initState();
    fetchPeople().then((value) {
      setState(() {
        _people.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: kPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: const Offset(1.0, 1.0), //Offset
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Text(
                    'People',
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
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  counterText: '',
                  label: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Text("Year"),
                        ),
                      ],
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: highlighted,
                  ),
                  hintText: "Choose the Year",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 15, right: 10),
                  floatingLabelStyle:
                      TextStyle(fontSize: 20, color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: Colors.purple[900]!),
                  ),
                ),
                menuMaxHeight: 220,
                alignment: Alignment.bottomCenter,
                dropdownColor: Color.fromARGB(255, 231, 239, 243),
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                itemHeight: 50,
                items: _yearGen().map<DropdownMenuItem<String>>((String value) {
                  return _getDropdown(value, value);
                }).toList(),
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please Choose a year';
                  }
                  return null;
                },
                value: _year,
                onChanged: (nv) {
                  setState(
                    () {
                      _year = nv;
                    },
                  );
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 35,
                  color: highlighted,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _year == null
                ? Column(
                    children: [
                      Text(
                        "No year selected!",
                        style: TextStyle(
                          color: highlighted,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.asset(
                          'assets/waiting.png',
                          fit: BoxFit.cover,
                          color: highlighted,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return _people[index].email!.contains(_year!.substring(4))
                          ? Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 8,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  radius: 30,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _people[index]
                                            .email!
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      )),
                                ),
                                title: Text(
                                  _people[index].name!,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                subtitle: Text(
                                  _people[index].email!,
                                ),
                              ),
                            )
                          : Container();
                    },
                    itemCount: _people.length,
                  ),
          ],
        ),
      ),
    );
  }
}
