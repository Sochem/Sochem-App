import 'package:flutter/material.dart';

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

final List<Widget> slidingImages = imgList
    .map(
      (item) => Container(
        width: 250,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: const Offset(
                1.0,
                1.0,
              ), //Offset
              blurRadius: 4.0,
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Image.asset(
                item,
                height: 125.0,
                alignment: Alignment.center,
              ),
            ),
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
              child: Text(
                '${imgTitle[imgList.indexOf(item)]}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    .toList();
