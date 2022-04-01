import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/people_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sochem/utils/endpoints.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  String? _year;
  late String token;
  List<People> _people = [];
  Future<List<People>> fetchPeople() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isLoggedIn)!) {
      token = prefs.getString(DjangoToken)!;
    } else {
      token = dotenv.get(GuestToken);
    }
    var response = await http.get(
      Uri.parse(Endpoints.family),
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

  List<String> _grps = [];
  void grpList(String val) {
    _grps = [];
    for (var x in _people) {
      if (x.email!.contains(val.substring(4)) &&
          !_grps.contains(x.house?.toUpperCase())) {
        _grps.add(x.house!.toUpperCase());
      }
    }
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

  List<Widget> _buildContent(int index) {
    List<Widget> contents = [];
    for (var content in _people) {
      if (content.house == _grps[index]) {
        contents.add(
          ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  content.email!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            title: Text(
              content.name!,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Flexible(
              child: Text(
                content.email!,
              ),
            ),
          ),
        );
      }
    }

    return contents;
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
                    'Groups',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
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
                  floatingLabelStyle: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple[900]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple[900]!,
                    ),
                  ),
                ),
                alignment: Alignment.bottomCenter,
                dropdownColor: Color.fromARGB(255, 225, 227, 228),
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                  grpList(nv!);
                  setState(
                    () {
                      _year = nv;
                    },
                  );
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 35,
                  color: highlighted,
                ),
              ),
            ),
            if (_year == null)
              Column(
                children: [
                  Text(
                    "No year selected!",
                    style: TextStyle(
                      color: highlighted,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                      WaitingIcon,
                      fit: BoxFit.cover,
                      color: highlighted,
                    ),
                  ),
                ],
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.purple[900]!),
                      ),
                      child: ExpansionTile(
                        iconColor: Colors.black,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _grps[index],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        children: _buildContent(index),
                      ),
                    ),
                  );
                },
                itemCount: _grps.length,
              ),
          ],
        ),
      ),
    );
  }
}
