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
  List<Notificationss> _alNotif = [], _allNotif = [];
  Map<String, String> notifenums = {
    '1': FeedIcon,
    '2': CloudIcon,
    '3': ForumIcon,
  };

  int vis = 0;

  bool highlight = false;
  Future<List<Notificationss>> fetchNotifs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(djangoToken);
    print(token.toString() + 'asdk');
    var response = await http
        .get(Uri.parse("https://api.sochem.org/api/notifi/"), headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token!
      // 'Token 262132f6ee56aba6dcdc9e7bd28ed1409fb45c98'
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

  void puraniId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = "";
    prefs.setInt(id, int.parse(_allNotif[0].id!));
  }

  @override
  void dispose() {
    super.dispose();
    puraniId();
  }

  @override
  void initState() {
    super.initState();
    fetchNotifs().then((value) {
      setState(() {
        _alNotif.addAll(value);
        _allNotif = new List.from(_alNotif.reversed);
      });
    });
    // print(_allNotif.toString());
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
                  shadowColor: index <= x - 1 ? Colors.red : Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: FittedBox(
                          child: Image(
                            image:
                                AssetImage(notifenums[_allNotif[index].type]!),
                          ),
                        )),
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
