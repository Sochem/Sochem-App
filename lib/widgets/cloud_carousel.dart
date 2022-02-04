import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/cloud-novels.png',
  'assets/cloud-coding.png',
  'assets/cloud-core.png',
  'assets/cloud-gate.png',
  'assets/cloud-gre.png',
  'assets/cloud-hulm.png',
  'assets/cloud-online.png',
];

final List<String> imgTitle = [
  'Books/Novels',
  'Code',
  'Core',
  'GATE',
  'GRE',
  'HULM',
  'Online Courses',
];

final List<Widget> slidingImages = imgList
    .map(
      (item) => Container(
        width: 250.0,
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
        child: Container(
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
              Expanded(
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    )
    .toList();

class CloudCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.21,
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
            ),
            items: slidingImages,
          ),
        ],
      ),
    );
  }
}
