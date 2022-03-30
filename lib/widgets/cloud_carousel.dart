import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  'assets/cloud_novels.png',
  'assets/cloud-coding.png',
  'assets/cloud-core.png',
  'assets/cloud-gate.png',
  'assets/cloud-gre.png',
  'assets/cloud-hulm.png',
  'assets/cloud-online.png',
  'assets/cloud_open_electives.png'
];

final List<String> imgTitle = [
  'Books/Novels',
  'Code',
  'Core',
  'GATE',
  'GRE',
  'HULM',
  'Online Courses',
  'Open Electives'
];

final List<String> bookTypesList = [
  'Books/Novels',
  'Code',
  'Core',
  'GATE',
  'GRE',
  'HULM',
  'Online Courses',
  'Open Electives'
];

final List<String> categoryLinks = [
  "https://drive.google.com/drive/folders/1TOxyPEmb8l9VvNAa1IycT7rBHIp2x_Wd?usp=sharing", //Novels
  "https://drive.google.com/drive/folders/1VYASsgV_Ods_EyHiKd_Sm7qjE1gyNpnU?usp=sharing", //Programming
  "https://drive.google.com/drive/folders/15pTBbGVUdA0dTGFQI7QpfQWaXDQsr6cy?usp=sharing", //Core
  "https://drive.google.com/drive/folders/1R34YagE19rLI31yMRQo4G-UnvHRRBmgn?usp=sharing", //GATE
  "https://drive.google.com/drive/folders/1mZSAyhN7BNX51g9V4if-6P1NWyFqtCmm?usp=sharing", //GRE
  "https://drive.google.com/drive/folders/18u9EqfPqZ7t9z9RL49WL1ebeW51t_eF-?usp=sharing", //HULM
  "https://drive.google.com/drive/folders/1ZGKENtgtA8UTCHcWIlSveJxg9_uX44vt?usp=sharing", //Online Courses
  "https://drive.google.com/drive/folders/1-FPXGNsfx7jcpLksfqqyo_7KA0KeOBi9?usp=sharing", //Open Electives
];

List<Widget> slidingImages(double height) {
  List<Widget> widgetList = [];
  for (int i = 0; i < bookTypesList.length; i++) {
    widgetList.add(
      GestureDetector(
        onTap: () {
          launch(categoryLinks[i]);
        },
        child: Container(
          width: 250,
          height: height * 0.18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: const Offset(1.0, 1.0), //Offset
                blurRadius: 4.0,
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Image.asset(
                  imgList[i],
                  height: height * 0.15,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                child: Text(
                  '${bookTypesList[i]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return widgetList;
}
