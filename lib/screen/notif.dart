import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sochem/models/notification_model.dart';
import 'package:sochem/utils/constants.dart';

class Notif extends StatefulWidget {
  Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  List<Notificationss> _allNotif = [];

  Future<List<Notificationss>> fetchNotifs() async {
    var response = await http
        .get(Uri.parse("https://api.sochem.org/api/notifi/"), headers: {
      HttpHeaders.authorizationHeader:
          'Token 262132f6ee56aba6dcdc9e7bd28ed1409fb45c98'
    });
    List<Notificationss> notifs = [];
    if (response.statusCode == 200) {
      var peopleJson = json.decode(response.body);
      for (var peoplesJson in peopleJson) {
        notifs.add(Notificationss.fromJson(peoplesJson));
      }
    }
    return notifs;
  }

  @override
  void initState() {
    super.initState();
    fetchNotifs().then((value) {
      setState(() {
        _allNotif.addAll(value);
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      radius: 30,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    title: Text(
                      _allNotif[index].title!,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      _allNotif[index].description!,
                    ),
                  ),
                );
              },
              itemCount: _allNotif.length,
            ),
          ],
        ),
      ),
    );
  }
}
