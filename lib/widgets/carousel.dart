import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sochem/models/home_carousel.dart';
import 'package:http/http.dart' as http;

import '../utils/endpoints.dart';

class HomeScreenCarousel extends StatefulWidget {
  @override
  State<HomeScreenCarousel> createState() => _HomeScreenCarouselState();
}

class _HomeScreenCarouselState extends State<HomeScreenCarousel> {
  List<HomeCarousel> _pics = [];
  Future<List<HomeCarousel>> fetchPics() async {
    var response = await http.get(
      Uri.parse(Endpoints.home_carousel),
      headers: {
        HttpHeaders.authorizationHeader:
            "Token 262132f6ee56aba6dcdc9e7bd28ed1409fb45c98"
      },
    );
    List<HomeCarousel> pics = [];
    if (response.statusCode == 200) {
      var picsJson = json.decode(response.body);
      for (var picJson in picsJson) {
        pics.add(HomeCarousel.fromJson(picJson));
      }
    }
    return pics;
  }

  //Books View
  @override
  void initState() {
    fetchPics().then((value) {
      setState(() {
        _pics.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.18,
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
        items: slidingImages(),
      ),
    );
  }

  List<Widget> slidingImages() {
    List<Widget> picList = [];
    print("hi");
    for (int i = 0; i < _pics.length; i++) {
      picList.add(
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: const Offset(1.0, 1.0), //Offset
                blurRadius: 4.0,
              ),
            ],
          ),
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  _pics[i].imageAddress,
                  fit: BoxFit.cover,
                  width: 1000.0,
                  alignment: Alignment.center,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(197, 75, 75, 75),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      _pics[i].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return picList;
  }
}
