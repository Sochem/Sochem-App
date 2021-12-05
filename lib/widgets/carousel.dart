import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://sochem.in/static/media/slide-home-3.d001fcc5.jpg',
  'https://osmoze.in/assets/images/gallery/2.png',
  'https://iitbhu.ac.in/sites/default/files/styles/iitbhu_slides/public/slides/che/slide_che_02.jpg?itok=R1Cmzwfi',
  'https://osmoze.in/assets/images/gallery/4.JPG',
  'https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
  'https://images.unsplash.com/photo-1565354785692-9e7523e5a87b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1035&q=80',
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            decoration: BoxDecoration(
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
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      item,
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
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item) + 1} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class ComplicatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.18,
              autoPlay: true,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
        ],
      ),
    );
  }
}
