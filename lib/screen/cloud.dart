import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sochem/models/books.dart';
import 'package:sochem/utils/constants.dart';
import 'package:sochem/widgets/cloud_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  "https://drive.google.com/drive/folders/1TOxyPEmb8l9VvNAa1IycT7rBHIp2x_Wd?usp=sharing", //novels
  "https://drive.google.com/drive/folders/1VYASsgV_Ods_EyHiKd_Sm7qjE1gyNpnU?usp=sharing", //Programming
  "https://drive.google.com/drive/folders/15pTBbGVUdA0dTGFQI7QpfQWaXDQsr6cy?usp=sharing", //Core
  "https://drive.google.com/drive/folders/1R34YagE19rLI31yMRQo4G-UnvHRRBmgn?usp=sharing", //GATE
  "https://drive.google.com/drive/folders/1mZSAyhN7BNX51g9V4if-6P1NWyFqtCmm?usp=sharing", //GRE
  "https://drive.google.com/drive/folders/18u9EqfPqZ7t9z9RL49WL1ebeW51t_eF-?usp=sharing", //HULM
  "https://drive.google.com/drive/folders/1ZGKENtgtA8UTCHcWIlSveJxg9_uX44vt?usp=sharing", //Online Courses
  "https://drive.google.com/drive/folders/1-FPXGNsfx7jcpLksfqqyo_7KA0KeOBi9?usp=sharing", //Open Electives
];

class CloudPage extends StatefulWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  State<CloudPage> createState() => _CloudPageState();
}

CarouselController buttonCarouselController = CarouselController();

class _CloudPageState extends State<CloudPage> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ), //Offset
                      blurRadius: 30.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 45.0),
                height: screensize.height * 0.35,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () =>
                              buttonCarouselController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Cloud",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  // letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new_rounded),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: () => buttonCarouselController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CloudCarousel(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: screensize.height * 0.635,
            child: ListView.builder(
                itemCount: bookTypesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      GenreTitle(
                        title: bookTypesList[index],
                        link: categoryLinks[index],
                      ),
                      BooksHorizontal(
                          genreURL:
                              'https://api.npoint.io/ce067c8d01658dad23b7'),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class BooksHorizontal extends StatefulWidget {
  const BooksHorizontal({required this.genreURL});
  final String genreURL;

  @override
  State<BooksHorizontal> createState() => _BooksHorizontalState();
}

class _BooksHorizontalState extends State<BooksHorizontal> {
  //Books viewmodel
  List<Book> _books = [];
  Future<List<Book>> fetchBooks() async {
    var response = await http.get(Uri.parse(widget.genreURL));

    List<Book> books = [];
    if (response.statusCode == 200) {
      var booksJson = json.decode(response.body);
      for (var bookJson in booksJson) {
        books.add(Book.fromJson(bookJson));
      }
    }
    return books;
  }

  //Books View
  @override
  void initState() {
    fetchBooks().then((value) {
      setState(() {
        _books.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
          height: 200.0,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: NetworkImage(_books[index].imageAddress),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  width: screensize.width * 0.36,
                ),
              );
            },
            itemCount: _books.length,
            scrollDirection: Axis.horizontal,
          )
          // This next line does the trick.

          ),
    );
  }
}

class GenreTitle extends StatelessWidget {
  const GenreTitle({required this.title, required this.link});
  final String title;
  final String link;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                print("Clicked");
                launch(link);
              },
              child: Text("View More"),
            ),
          ],
        ),
      ),
    );
  }
}

class CloudCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.21,
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
        items: slidingImages,
      ),
    );
  }
}
