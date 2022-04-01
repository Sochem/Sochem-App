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
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              _grps[index1],
                              style: TextStyle(
                                fontSize: 30,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                // backgroundColor: kBackgroundColor,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.vertical,

                              itemBuilder: (context, index) {
                                return _people[index].house == _grps[index1]
                                    ? Card(
                                        // elevation: 5,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 8,
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.primaries[
                                                Random().nextInt(
                                                    Colors.primaries.length)],
                                            radius: 30,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          subtitle: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  _people[index].email!,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                              itemCount: _people.length,
                            ),
                            SizedBox(
                              height: 15,
                            ),
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
