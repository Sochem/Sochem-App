import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sochem/models/notification_model.dart';
import 'package:sochem/utils/constants.dart';

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
    String? token = prefs.getString(djangoToken);
    oldId = prefs.getInt(lastNotifId)!;

    var response = await http.get(
      Uri.parse("https://api.sochem.org/api/notifi/"),
      headers: {HttpHeaders.authorizationHeader: 'Token ' + token!},
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
          'Notifications',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kBackgroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shadowColor: int.parse(_allNotif[index].id) > oldId
                  ? Colors.red
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
    );
  }
}
