import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sochem/models/people_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:http/http.dart' as http;

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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

  List<String> _grps = [];
  void grpList(String val) {
    _grps.clear();
    for (var x in _people) {
      // print(x.email!.substring(x.email!.length - 17, x.email!.length - 12) +
      // "asdk");
      // print(val);
      // print(x.email!.contains(val.substring(4)));
      if (x.email!.contains(val.substring(4)) &&
          !_grps.contains(x.house?.toUpperCase())) {
        print(x.house);
        _grps.add(x.house!.toUpperCase());
      }
    }
    // _grps!.forEach((key, value) { })

    print(_grps);
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

  List<Widget> _buildContent(int index1) {
    List<Widget> contents = [];

    for (var content in _people) {
      if (content.house == _grps[index1]) {
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
                  )),
            ),
            title: Text(
              content.name!,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    content.email!,
                  ),
                ),
              ],
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
      appBar: AppBar(
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: kBackgroundColor,
          iconSize: 30,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          'Groups',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kBackgroundColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(ProfileIcon),
              backgroundColor: kBackgroundColor,
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                dropdownColor: kBackgroundColor,
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index1) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                            side: BorderSide(color: Colors.purple[900]!)),
                        // color: ,
                        child: ExpansionTile(
                          // collapsedBackgroundColor: cardImageColor,
                          iconColor: Colors.black,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                // gradient: LinearGradient(
                                //   begin: Alignment.topLeft,
                                //   end: Alignment.bottomRight,
                                //   colors: [Color(0xFFFFECDF), kBackgroundColor],
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  _grps[index1],
                                  style: TextStyle(
                                    fontSize: 30,
                                    // color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: kBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: _buildContent(index1),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
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
