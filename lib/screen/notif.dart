import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/notification_model.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/utils/endpoints.dart';

class Notif extends StatefulWidget {
  Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  late SharedPreferences prefs;
  List<Notifications> _allNotif = [];
  Map<String, String> notifEnums = {
    '1': FeedIcon,
    '2': CloudIcon,
    '3': ForumIcon,
  };
  late int oldId;

  Future<List<Notifications>> fetchNotifs() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(DjangoToken)!;
    oldId = prefs.getInt(lastNotifId)!;

    var response = await http.get(
      Uri.parse(Endpoints.notif),
      headers: {HttpHeaders.authorizationHeader: token},
    );

    List<Notifications> notifs = [];
    if (response.statusCode == 200) {
      var peopleJson = json.decode(response.body);
      for (var peoplesJson in peopleJson) {
        notifs.add(Notifications.fromJson(peoplesJson));
      }
    }
    return notifs;
  }

  @override
  void dispose() {
    prefs.setInt(lastNotifId, int.parse(_allNotif[0].id));
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchNotifs().then((value) {
      setState(() {
        _allNotif = new List.from(value.reversed);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  'Notifications',
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
          Expanded(
            child: _allNotif.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shadowColor: int.parse(_allNotif[index].id) > oldId
                            ? blue3
                            : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: FittedBox(
                              child: Image.asset(
                                notifEnums[_allNotif[index].type]!,
                              ),
                            ),
                          ),
                          title: Text(
                            _allNotif[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(
                            _allNotif[index].description,
                          ),
                        ),
                      );
                    },
                    itemCount: _allNotif.length,
                  ),
          ),
        ],
      ),
    );
  }
}
